require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user, delivery_address: user.address,
      client_phone: user.phone_number) }
    
    before { get :show, params: { id: order.id } }

    it "assigns the requested order to @order" do
      expect(assigns(:order)).to eq(order) 
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end