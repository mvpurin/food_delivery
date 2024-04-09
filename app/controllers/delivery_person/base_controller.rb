class DeliveryPerson::BaseController < ApplicationController
  layout 'delivery_person'

  before_action :authenticate_delivery_person!
  before_action :delivery_person_required!

  private

  def delivery_person_required!
    redirect_to root_path, 
      alert: 'Sorry, you are not authorized to view this page.'
        unless current_user.is_a?(DeliveryPerson)
  end
end