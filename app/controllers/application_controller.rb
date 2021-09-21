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
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name role])
  end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s
    flash[:error] = if current_user.try(:admin?)
                      { heading: policy_name.to_s, message: "#{exception} (#{exception.record})" }
                    else
                      { heading: 'Unauthorized action', message: "You do not have the proper permissions to perform that #{exception.record.to_s.humanize} action." }
                    end
    redirect_to(request.referrer || wikis_path)
  end
end
