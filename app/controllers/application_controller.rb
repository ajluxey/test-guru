class ApplicationController < ActionController::Base  
  
  helper_method :current_user
  before_action :authenticate_user!

  private

  def authenticate_user!
    unless current_user
      redirect_to login_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    @current_user.present?
  end
end
