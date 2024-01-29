require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

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
        expect(response).to redirect_to categories_path
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

end
