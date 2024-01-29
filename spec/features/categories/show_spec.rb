require 'rails_helper'

feature 'User can see list of items in a category', '
  User can see list of all items in a category' do
    describe 'User' do
      let(:category) { create(:category) }
      let!(:items) { create_list(:item, 2, category: category) }

      scenario 'can see list of items' do
        visit category_path(category)

        expect(page).to have_content Item.first.name
        expect(page).to have_content Item.last.name
      end
    end
  end