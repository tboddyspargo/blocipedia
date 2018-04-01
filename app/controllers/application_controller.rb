class ApplicationController < ActionController::Base
  include Pundit
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  prepend_before_action :configure_permitted_params, if: :devise_controller?

  protected

  def configure_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :role])
  end
  
  private
  
  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    if current_user.try(:admin?)
      flash[:error] = { heading: "#{policy_name}", message: "#{exception.query}" }
    else
      flash[:error] = "Hey! What do you think you're trying to do?"
    end
    redirect_to(request.referrer || wikis_path)
  end
  
end
