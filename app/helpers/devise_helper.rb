module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    flash.now[:error] = {
      heading: sentence,
      errors: resource.errors.full_messages
    }
    return ""
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

end