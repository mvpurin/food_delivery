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
end