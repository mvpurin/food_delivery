require 'rails_helper'

feature 'User can add items to order', '
  User can add some items to order and see list of items in the order' do
    given(:user) { create(:user) }
    given(:category) { create(:category) }
    given!(:item) { create(:item, category: category) }

    describe 'User' do
      background { sign_in(user) }

      scenario 'can add items to the order' do
        visit category_path(category)
        click_on 'Add to order'

        expect(page).to have_content 'Added successfully!'
      end
    end
  end