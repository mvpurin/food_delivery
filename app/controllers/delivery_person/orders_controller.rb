class DeliveryPerson::OrdersController < ApplicationController
  before_action :authenticate_delivery_person!

  def index

  end

  def complete
    order = current_delivery_person.order
    
    ActiveRecord::Base.transaction do
      order.update(status: 'completed')
      current_delivery_person.update(order: nil)
      current_delivery_person.update(status: 'free')
    end
  end
end