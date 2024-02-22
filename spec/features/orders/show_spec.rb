require 'rails_helper'

feature 'User can see his order', '
Authenticated user can see list of items in his order
  with their amounts, prices and a common price' do
  given(:category) { create(:category) }
  given!(:items) { create_list(:item, 2, category: category) }

  describe 'User' do
    given(:user) { create(:user) }

    background do
      sign_in(user)
      visit category_path(category)

      within "#item-#{Item.first.id}" do
        click_on 'Add to order' 
      end

      within "#item-#{Item.last.id}" do
        click_on 'Add to order'
      end
    end

    scenario 'tries to see his order' do
      click_on 'My order'

      expect(page).to have_content Item.first.name
      expect(page).to have_content "Amount: 1"
      expect(page).to have_content "Price: #{Item.first.price}"

      expect(page).to have_content Item.last.name
      expect(page).to have_content "Amount: 1"
      expect(page).to have_content "Price: #{Item.last.price}"

      expect(page).to have_content "Total price: #{Item.first.price + Item.last.price}"
    end
  end

  scenario 'Unauthenticated user' do
    visit category_path(category)
    expect(page).to_not have_content 'My order'
  end
end