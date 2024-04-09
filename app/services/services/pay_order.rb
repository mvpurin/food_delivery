module Services
  class PayOrder
    def call(order)
      ActiveRecord::Base.transaction do
        order.pay
        Services::AddCourierToOrder.new.call(order)
      end
      return true
    rescue StandardError => e
      return e.message
    end
  end
end