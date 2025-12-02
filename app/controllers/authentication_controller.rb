class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:signup, :login]

  # POST /signup
  def signup
    user = User.new(user_params)

    if user.save
      render json: {
        message: "User created successfully",
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }, status: :created
    else
      render json: { message: "Validation failed", errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:authentication][:email])

    if user&.authenticate(params[:authentication][:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: {
        message: "Login successful",
        token: token,
        user: { id: user.id, name: user.name, email: user.email }
      }, status: :ok
    else
      render json: { message: "Invalid email or password" }, status: :unauthorized
    end
  end

  def sign_out
    render json: { message: "Sign out successfully" }, status: :ok
  end

  private

  def user_params
    params.require(:authentication).permit(:name, :email, :password, :password_confirmation)
  end
end
