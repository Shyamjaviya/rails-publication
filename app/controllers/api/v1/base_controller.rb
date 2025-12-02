class Api::V1::BaseController < ApplicationController
  before_action :current_user


  def success_response(data = {}, message = "Success", status = :ok)
    render json: {
      success: true,
      message: message,
      data: data
    }, status: status
  end

  def error_response(errors = {}, message = "Failed", status = :unprocessable_entity)
    render json: {
      success: false,
      message: message,
      errors: errors
    }, status: status
  end

  private

  def current_user
    header = request.headers["Authorization"]
    token = header.split(" ").last if header.present?

    begin
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { message: "Invalid or missing token" }, status: :unauthorized
    end
  end
end
