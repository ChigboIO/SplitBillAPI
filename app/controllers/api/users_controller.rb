class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user_from_token, only: :create

  def create
    @user = User.new(user_params)
    render json: @user, status: 201 and return if @user.save

    render json: @user.errors.full_messages, status: 400
  end

  private

  def user_params
    params.permit(:name, :email, :username, :password)
  end
end
