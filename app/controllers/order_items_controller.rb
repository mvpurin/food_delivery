class OrderItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @order = Services::FindOrder.new.call(current_user)
    @order_item = Services::FindOrderItem.new.call(@item, @order)
    @order_item.amount += 1
    @order_item.save
    
    redirect_to category_path(@item.category), notice: 'Added successfully!'
  end
end
