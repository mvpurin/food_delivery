module Services
  class AddCourierToOrder
    def call(order)
      if delivery_person
        ActiveRecord::Base.transaction do
          order.update!(delivery_person: delivery_person)
          delivery_person.update!(status: 'in delivery')
        end
      end
    end

    private

    def delivery_person
      delivery_person ||= DeliveryPerson.where(status: 'free').first
    end
  end
end