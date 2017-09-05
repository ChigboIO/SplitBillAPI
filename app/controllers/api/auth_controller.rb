class Api::AuthController < Api::BaseController
  skip_before_action :authenticate_user_from_token, only: :login

  def login
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      token = JwtProvider.encode('user_id': user.id)
      user.tokens.create(value: token)
      render json: { notice: 'Login successful', token: token }, status: 201 and return
    end

    render json: { error: 'Incorrect username or password' }, status: 400
  end

  def logout
    Token.find_by(value: token).destroy
    render json: { notice: 'You are now logged out' }, status: 200
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
