class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, only: [:show, :edit, :update, :pay]

  def show
    
  end

  def edit

  end

  def update
    if @order.update(order_params)
      redirect_to edit_order_path(@order)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def pay
    @order.pay
    Services::AddCourierToOrder.new.call(@order)
    redirect_to categories_path, notice: 'Successfully payed!'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to categories_path, notice: 'Some problems, please try again...'
  end

  private

  def load_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:delivery_address, :client_phone, :comment)
  end
end
