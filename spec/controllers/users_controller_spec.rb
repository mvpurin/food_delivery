require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #previous_orders' do
    let(:user) { create(:user) }
    let!(:orders) { create_list(:order, 3, user: user, delivery_address: user.address,
    client_phone: user.phone_number, status: 'closed') }

    before do
      login(user)
      get :previous_orders, params: { id: user.id }
    end

    it 'populates an array of all previous orders' do
      expect(assigns(:orders)).to match_array(orders)
    end
  end
end