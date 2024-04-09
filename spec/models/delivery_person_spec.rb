require 'rails_helper'

RSpec.describe DeliveryPerson, type: :model do
  it { should have_one(:order) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_uniqueness_of(:phone_number) }

  describe '#complete_order' do
    let(:user) { create(:user) }
    let(:delivery_person) { create(:delivery_person, status: 'in delivery') }
    let(:category) { create(:category) }
    let!(:order) { create(:order, user: user, status: 'in delivery', delivery_person: delivery_person,
      delivery_address: user.address, client_phone: user.phone_number) }

    it 'completes the order' do
      expect(order.status).to eq 'in delivery'
      expect(delivery_person.status).to eq 'in delivery'

      delivery_person.complete_order

      expect(order.reload.status).to eq 'completed'
      expect(delivery_person.reload.order).to be_nil
      expect(delivery_person.reload.status).to eq 'free'
    end

    it 'rolls back changes if there is an error in transaction' do
      allow(delivery_person.order).to receive(:update!).and_raise(ActiveRecord::RecordInvalid)

      expect { delivery_person.complete_order }.to raise_error(ActiveRecord::RecordInvalid)
      expect(delivery_person.reload.status).to eq 'in delivery'
      expect(delivery_person.reload.order).to eq order
      expect(order.reload.status).to eq 'in delivery'
    end
  end
end
