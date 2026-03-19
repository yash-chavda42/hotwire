class ApplicationController < ActionController::Base
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create], if: :auth_controller?
  helper_method :current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def auth_controller?
    controller_name.in?(%w[sessions users])
  end
  
  def redirect_if_logged_in
    redirect_to notes_path if current_user
  end
end
