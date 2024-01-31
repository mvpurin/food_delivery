require 'rails_helper'

RSpec.describe Services::FindOrder do
  let(:user) { create(:user) }
  subject { Services::FindOrder.new }

  context "user does not have an order with 'in progress' status" do
    it 'creates and returns a new order' do
      expect { subject.call(user) }.to change(Order, :count).by(1)
    end
  end

  context "user already has an order with 'in progress' status" do
    let!(:order) { create(:order, user: user, status: 'in progress', delivery_address: user.address, client_phone: user.phone_number) }

    it 'returns the existing order' do
      expect(subject.call(user)).to eq order
    end

    it 'does not creates a new order' do
      expect { subject.call(user) }.to_not change(Order, :count)
    end
  end
end