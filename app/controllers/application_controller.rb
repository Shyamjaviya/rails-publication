class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  # protect_from_forgery with: :null_session
  skip_forgery_protection

  before_action :authorize_request

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last rescue nil

    decoded = JsonWebToken.decode(token)
    if decoded.nil?
      render json: { message: "Invalid or missing token" }, status: :unauthorized
    else
      @current_user = User.find(decoded[:user_id])
    end
  end
end
