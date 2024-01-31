require 'rails_helper'

RSpec.describe Services::FindOrderItem do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item) { create(:item, category: category) }
  let(:order) { create(:order, user: user, status: 'in progress', delivery_address: user.address, client_phone: user.phone_number) }
 
  subject { Services::FindOrderItem.new }

  context 'Order does not have the item' do
    it 'creates a new OrderItem instance' do
      expect { subject.call(item, order) }.to change(order.order_items, :count).by(1)
    end
  end

  context 'Order already has the item' do
    let!(:order_item) { create(:order_item, item: item, order: order) }

    it 'returns the existing OrderItem instance' do
      expect(subject.call(item, order)).to eq order_item
    end

    it 'does not create a new OrderItem instance' do
      expect { subject.call(item, order) }.to_not change(order.order_items, :count)
    end
  end
end