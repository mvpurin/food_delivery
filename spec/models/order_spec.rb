require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:items).through(:order_items) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:total_price) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:payment_method) }
  it { should validate_presence_of(:delivery_address) }
  it { should validate_presence_of(:client_phone) }

  describe '#total_price' do 
    it 'calculates the total price of the order' do 
      order = instance_double('Order')
      allow(order).to receive(:order_items)
        .and_return([instance_double('OrderItem', price: 10, amount: 2),
        instance_double('OrderItem', price: 20, amount: 1)])
      allow(order).to receive(:summ_price).and_return(40)
      total_price = order.summ_price

      expect(total_price).to eq(40)
    end
  end

  describe '#decrease_items_amount' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:item_1) { create(:item, category: category, amount: 100) }
    let(:item_2) { create(:item, category: category, amount: 200) }
    let(:order) { create(:order, user: user, delivery_address: user.address, client_phone: user.phone_number) }
    let!(:order_item_1) { create(:order_item, item: item_1, order: order, amount: 10) }
    let!(:order_item_2) { create(:order_item, item: item_2, order: order, amount: 20) }

    before { order.decrease_items_amount }

    it 'decreases amount of items by the amount of ordered items' do
      expect(item_1.reload.amount).to eq 90
      expect(item_2.reload.amount).to eq 180
    end
  end
end