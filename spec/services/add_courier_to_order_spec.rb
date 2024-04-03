require 'rails_helper'

RSpec.describe Services::AddCourierToOrder do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:item) { create(:item, category: category) }
  let!(:order) { create(:order, user: user, status: 'in delivery', delivery_address: user.address, client_phone: user.phone_number) }
  let!(:delivery_person) { create(:delivery_person) }

  subject { Services::AddCourierToOrder.new }

  context 'there is a free courier' do
    it 'adds a free courier to the order' do
      expect { subject.call(order) }.to change(order, :delivery_person).to delivery_person
    end

    it 'changes status of courier to "in delivery"' do
      expect { subject.call(order) }.to change { delivery_person.reload.status }.to 'in delivery'
    end
  end
end