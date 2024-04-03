require 'rails_helper'

RSpec.describe DeliveryPerson::OrdersController, type: :controller do
  describe 'PATCH #complete' do
    let(:user) { create(:user) }
    let(:delivery_person) { create(:delivery_person) }
    let(:category) { create(:category) }
    let(:item_1) { create(:item, category: category, amount: 100) }
    let(:item_2) { create(:item, category: category, amount: 200) }
    let!(:order) { create(:order, user: user, delivery_person: delivery_person, delivery_address: user.address, client_phone: user.phone_number) }

    before { login_courier(delivery_person) }
    before { patch :complete, params: { id: order.id } }
    
    it 'updated the order status' do
      expect(order.reload.status).to eq 'completed'
    end

    it 'removes current order from delivery person' do
      expect(delivery_person.reload.order).to be_nil
    end
  end
end