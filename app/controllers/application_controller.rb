class ApplicationController < ActionController::Base
  before_action :configurate_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_categories_path : categories_path
  end

  private

  def configurate_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :phone_number])
  end
end
