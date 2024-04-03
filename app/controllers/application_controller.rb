class ApplicationController < ActionController::Base
  before_action :configurate_permitted_parameters, if: :devise_controller?

  devise_group :delivery_person, contains: [:delivery_person]

  def after_sign_in_path_for(resource)
    if resource.class == User && resource.admin?
      return admin_categories_url
    elsif resource.class == User && !resource.admin?
      return categories_url
    elsif resource.class == DeliveryPerson
      return delivery_person_orders_url
    end
  end

  private

  def configurate_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :phone_number])
  end
end
