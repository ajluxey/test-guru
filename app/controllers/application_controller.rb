class ApplicationController < ActionController::Base  
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :login, :password)}

		devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :login, :password, :current_password)}
	end

  private

  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? admin_tests_path : tests_path
  end

end
