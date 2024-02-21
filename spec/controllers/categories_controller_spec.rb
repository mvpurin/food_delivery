require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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
