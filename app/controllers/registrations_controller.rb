class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:unsubscribe_from_premium, :edit_user_password_path]
  
  def unsubscribe_from_premium
    if not user_signed_in?
      flash[:error] = { heading: 'Account not changed', message: "You must sign in to change your account type." }
      redirect_to new_user_session_path
    elsif current_user.premium?
      # Make private wikis public so they will be accessible after downgrade.
      current_user.wikis.each do |wiki|
        if wiki.private
          wiki.assign_attributes(private: false)
          wiki.save
        end
      end
      
      current_user.standard!
      redirect_to edit_user_registration_path
    else
      flash[:warning] = { heading: 'Account not changed', message: "You're account isn't a Premium account, so it could not be unsubscribed from Premium." }
      redirect_to edit_user_registration_path
    end
  end
  
  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      flash[:success] = "Password changed."
      redirect_to root_path
    else
      render :edit
    end
  end
  
  protected
  
    def update_resource(resource, params)
      resource.update_without_password(params)
    end
    
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end
end