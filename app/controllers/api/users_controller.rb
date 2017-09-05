class Api::UsersController < Api::BaseController
  skip_before_action :authenticate_user_from_token, only: :create

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render json: @user.errors.full_messages, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email, :username, :password)
  end
end
