class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def previous_orders
    @orders = Order.where(user: current_user.id, status: 'closed')
  end
end
