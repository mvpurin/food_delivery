require 'rails_helper'

feature 'User can add items to order', '
  User can add some items to order and see list of items in the order' do
    given(:user) { create(:user) }
    given(:category) { create(:category) }
    given!(:item) { create(:item, category: category) }
    given!(:empty_item) { create(:item, category: category, amount: 0) }

    describe 'User' do
      background { sign_in(user) }

      scenario 'can add items to the order' do
        visit category_path(category)

        within("#item-#{item.id}") do
          click_on 'Add to order'
        end

        expect(page).to have_content 'Added successfully!'
      end

      scenario ' can not add items with zero amount' do
        visit category_path(category)

        within("#item-#{empty_item.id}") do
          expect(page).to_not have_content 'Add to order'
        end
      end
    end
  end