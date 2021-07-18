class ApplicationController < ActionController::Base  
  
  helper_method :current_user, :logged_in?
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless current_user
      store_return_to
      redirect_to login_path, alert: 'Are you a Guru? Verify your Email and Password please'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    @current_user.present?
  end

  def store_return_to
    cookies[:return_to] = request.url
  end

end
