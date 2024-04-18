module Services
  class PayOrder
    def call(order)
      ActiveRecord::Base.transaction do
        order.pay
        Services::AddCourierToOrder.new.call(order)
      end
      return { result: true }
    rescue StandardError => e
      return { result: false, error: e.message }
    end
  end
end