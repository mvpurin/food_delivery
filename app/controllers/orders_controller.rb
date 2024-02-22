class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, only: [:show, :edit]

  def show
    
  end

  def edit

  end

  private

  def load_order
    @order = Order.find(params[:id])
  end
end
