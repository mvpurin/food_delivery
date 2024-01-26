require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #new" do
    before { get :new }

    it 'assigns a new category to @category' do
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves new category to the database' do
        expect { post :create, params: { category: attributes_for(:category) } }.to change(Category, :count).by(1)
      end

      it 'redirects to index view' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to categories_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save new category to the database' do
        expect { post :create, params: { category: attributes_for(:category, :invalid) } }.to_not change(Category, :count)
      end
      
      it 'renders new view' do
        post :create, params: { category: attributes_for(:category, :invalid) }
        expect(response).to render_template :new
      end
    end
  end
end
