class Api::AuthController < Api::BaseController
  def login
    user = User.find_by(email: auth_params[:email])
    if user && user.authenticate(auth_params[:password])
      token = JsonWebToken.encode('user_id': user.id)
      user.tokens.create(value: token)
      render json: { notice: 'Login successful', token: token }, status: 201
    else
      render json: { error: 'Incorrect username or password' }, status: 400
    end
  end

  def logout
    Token.find_by(value: get_token).destroy
    render json: { notice: 'You are now logged out' }, status: 200
  end

  def auth_params
    params.permit(:email, :password)
  end
end
