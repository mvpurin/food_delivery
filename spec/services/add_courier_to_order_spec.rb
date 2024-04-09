require 'rails_helper'

RSpec.describe Services::AddCourierToOrder do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item) { create(:item, category: category) }
  let!(:order) { create(:order, user: user, status: 'in delivery',
    delivery_address: user.address, client_phone: user.phone_number) }
  let!(:delivery_person) { create(:delivery_person) }

  subject { Services::AddCourierToOrder.new }

  context 'there is a free courier' do
    it 'adds a free courier to the order' do
      expect { subject.call(order) }.to change(order, :delivery_person).to delivery_person
    end

    it 'changes status of courier to "in delivery"' do
      expect { subject.call(order) }.to change { delivery_person.reload.status }.to 'in delivery'
    end

    it 'rolls back changes if there is an error in transaction' do
      allow(order).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)
      expect { subject.call(order) }.to raise_error(ActiveRecord::RecordInvalid)
      expect(order.reload.delivery_person).to be_nil
      expect(delivery_person.reload.status).to eq 'free'
    end
  end
end