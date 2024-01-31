module Services
  class FindOrderItem
    def call(item, order)
      @item = item
      @order = order
      @order_item = @order.order_items.find_by(item_id: @item.id)

      if @order_item.nil?
        @order_item = @order.order_items.create!(order_item_params)
        return @order_item
      else
        return @order_item
      end
    end

    private

    def order_item_params
      { price: @item.price, amount: 0, item_id: @item.id }
    end
  end
end