require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "GET #show" do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user, delivery_address: user.address,
      client_phone: user.phone_number) }
    
    before { login(user) }
    before { get :show, params: { id: order.id } }

    it "assigns the requested order to @order" do
      expect(assigns(:order)).to eq(order) 
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }
    let(:order) { create(:order, user: user, delivery_address: user.address,
      client_phone: user.phone_number) }
    
    before { login(user) }

    context 'with valid attributes' do
      before { patch :update, params: { id: order.id, order: { delivery_address: 'Changed address',
        client_phone: '123' } } }

      it 'assigns the requested order to @order' do
        expect(assigns(:order)).to eq order
      end

      it 'updates @order' do
        expect(order.reload.delivery_address).to eq 'Changed address'
        expect(order.reload.client_phone).to eq '123'
      end

      it 'redirects to edit view' do
        expect(response).to redirect_to edit_order_path(order)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the @order' do
        expect do
          patch :update, params: { id: order.id, order: { delivery_address: '' } }
        end.not_to change(order, :delivery_address)
      end

      it 'renders edit view' do
        patch :update, params: { id: order.id, order: { delivery_address: '' } }
        expect(response).to render_template :edit
      end
    end
  end
end