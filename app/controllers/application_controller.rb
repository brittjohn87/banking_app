class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # devise over the entire app 
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?



  protected 

	def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
   devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role])
	end

	rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, :alert => "Not Authorized!" }
    end
  end

end

