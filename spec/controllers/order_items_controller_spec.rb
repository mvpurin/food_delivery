require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let(:item) { create(:item, category: category) }

    before { login(user) }
    before { post :create, params: { item_id: item.id } }

    it 'assigns requested item to @item' do
      expect(assigns(:item)).to eq item
    end

    it 'incrases order_item amount by 1' do
      expect(assigns(:order_item).amount).to eq 1
    end

    it 'does not create a new one OrderItem instance' do
      expect(OrderItem.count).to eq 1
    end

    it 'redirects to category path' do
      expect(response).to redirect_to category
    end
  end
end
