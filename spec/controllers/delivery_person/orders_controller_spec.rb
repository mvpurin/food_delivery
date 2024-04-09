require 'rails_helper'

RSpec.describe DeliveryPerson::OrdersController, type: :controller do
  describe 'PATCH #complete' do
    let(:user) { create(:user) }
    let(:delivery_person) { create(:delivery_person) }
    let(:order) { create(:order, user: user, delivery_person: delivery_person,
      delivery_address: user.address, client_phone: user.phone_number) }

    before { login_courier(delivery_person) }

    it 'calls #complete_order method' do    
      allow(controller).to receive(:current_delivery_person).and_return(delivery_person)
      expect(delivery_person).to receive(:complete_order)
      patch :complete, params: { id: order.id }
    end
  end
end