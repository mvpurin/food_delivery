module Services
  class AddCourierToOrder
    def call(order)
      delivery_person = find_delivery_person
      if delivery_person
        order.update(delivery_person: delivery_person)
        delivery_person.update(status: 'in delivery')
      end
    end

    private

    def find_delivery_person
      delivery_person = DeliveryPerson.where(status: 'free').first
      delivery_person.present? ? delivery_person : nil
    end
  end
end