require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:orders).dependent(:destroy) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:phone_number) }

  describe 'current_order' do 
    let(:user) { create(:user) }

    it 'returns the order that is in progress' do 
      order = Order.create(user: user, total_price: 0.0, status: 'in progress',
        payment_method: 'some method', delivery_address: user.address,
        client_phone: user.phone_number)
      
      expect(user.current_order).to eq order
    end

    it 'returns nil if there is no order in progress' do
      expect(user.current_order).to be_nil
    end
  end
end
