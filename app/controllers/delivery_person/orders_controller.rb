class DeliveryPerson::OrdersController < ApplicationController
  before_action :authenticate_delivery_person!

  def index

  end

  def complete
    current_delivery_person.complete_order
  end
end