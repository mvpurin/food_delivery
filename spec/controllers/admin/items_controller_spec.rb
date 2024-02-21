require 'rails_helper'

RSpec.describe Admin::ItemsController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  before { login(admin) }

  describe "GET #new" do
    let(:category) { create(:category) }
    
    before { get :new, params: { category_id: category } }

    it 'assigns a new item to @item' do
      expect(assigns(:item)).to be_a_new(Item)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'saves new item to the database' do
        expect { post :create, params: { item: attributes_for(:item), category_id: category } }.to change(Item, :count).by(1)
      end

      it 'redirects to index view' do
        post :create, params: { item: attributes_for(:item), category_id: category }
        expect(response).to redirect_to admin_categories_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save new item to the database' do
        expect do
          post :create, params: { item: attributes_for(:item, :invalid), category_id: category }
        end.not_to change(Item, :count)
      end

      it 'renders new view' do
        post :create, params: { item: attributes_for(:item, :invalid), category_id: category }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category) }
    let(:item) { create(:item, category: category) }

    context 'with valid attributes' do
      before { patch :update, params: { id: item.id, item: { name: 'Changed item name' } } }

      it 'assigns the requested item to @item' do
        expect(assigns(:item)).to eq item
      end

      it 'updates @item' do
        expect(item.reload.name).to eq 'Changed item name'
      end

      it 'redirects to index view' do
        expect(response).to redirect_to admin_category_path(category)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the @item' do
        expect do
          patch :update, params: { id: item.id, item: attributes_for(:item, :invalid) }
        end.not_to change(item, :name)
      end

      it 'renders edit view' do
        patch :update, params: { id: item.id, item: attributes_for(:item, :invalid) }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
  let(:category) { create(:category) }
  let!(:item) { create(:item, category: category) }

  it 'assigns the requested item to @item' do
    delete :destroy, params: { id: item }
    expect(assigns(:item)).to eq item
  end

  it 'deletes the item' do
    expect { delete :destroy, params: { id: item } }.to change(Item, :count).by(-1)
  end

  it 'redirects to show view' do
    delete :destroy, params: { id: item }
    expect(response).to redirect_to admin_category_path(category)
  end
end
end
