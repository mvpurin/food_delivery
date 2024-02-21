require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin) { create(:user, admin: true) }
  before { login(admin) }

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new category to @category' do
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end

    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves new category to the database' do
        expect { post :create, params: { category: attributes_for(:category) } }.to change(Category, :count).by(1)
      end

      it 'redirects to index view' do
        post :create, params: { category: attributes_for(:category) }
        expect(response).to redirect_to admin_categories_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save new category to the database' do
        expect do
          post :create, params: { category: attributes_for(:category, :invalid) }
        end.not_to change(Category, :count)
      end

      it 'renders new view' do
        post :create, params: { category: attributes_for(:category, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #index' do
    let!(:categories) { create_list(:category, 3) }
    before { get :index }

    it 'populates an array of all categories' do
      expect(assigns(:categories)).to match_array(categories)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:category) { create(:category) }
    before { get :show, params: { id: category.id } }

    it 'assigns requested category to @category' do
      expect(assigns(:category)).to eq category
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
