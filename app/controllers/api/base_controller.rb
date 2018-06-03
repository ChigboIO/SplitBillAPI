class Api::BaseController < ActionController::API
  before_action :authenticate_user_from_token, except: :no_route

  attr_reader :current_user
  attr_reader :token
  helper_method :current_user

  def no_route
    verb = request.method
    render json: { error: 'Path not found', path: "/#{params[:path]}", verb: verb }, status: 404
  end

  def render_with_not_found(resource)
    render json: { error: "#{resource} with given ID not found" }, status: 404
  end

  def render_with_unauthorized(resource)
    render json: { error: "Unauthorized action on this #{resource}" }, status: 401
  end

  private

  def authenticate_user_from_token
    payload = JwtProvider.decode(get_token_from_header)
    @current_user = User.find_by(id: payload['user_id']) if payload
    unauthorized_response unless @current_user.present?
  rescue JWT::ExpiredSignature
    unauthorized_response('Auth token has expired')
  rescue JWT::DecodeError
    unauthorized_response('Invalid auth token')
  end

  def get_token_from_header
    auth_header = request.headers['Authorization']
    return unless auth_header

    @token = auth_header.split(' ').last
    return @token if Token.find_by(value: @token)
  end

  def unauthorized_response(message = '')
    render json: { error: "Unauthorized access. #{message}" }, status: 401
  end
end
