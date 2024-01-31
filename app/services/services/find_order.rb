module Services
  class FindOrder
    def call(user)
      @user = user
      order = Order.where(user_id: @user.id, status: 'in progress').first
      
      if order.present?
        return order
      else
        order = @user.orders.create!(order_params)
        return order
      end
    end

    private

    def order_params
      { total_price: 0, payment_method: 'some method', delivery_address: @user.address, client_phone: @user.phone_number }
    end
  end
end