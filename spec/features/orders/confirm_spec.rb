require 'rails_helper'

feature 'Authenticated user can confirm his order', '
Authenticated user can check his order' do
  describe 'User' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    let!(:items) { create_list(:item, 2, category: category) }

    background do
      sign_in(user)
      visit category_path(category)

      within("#item-#{Item.first.id}") do
        click_on 'Add to order'
      end

      within("#item-#{Item.last.id}") do
      click_on 'Add to order'
      end

      click_on 'My order'
      click_on 'Confirm order'
    end

    scenario 'tries to confirm his order' do
      expect(page).to have_content "Total price: #{Item.first.price + Item.last.price}"
      expect(page).to have_content 'Please check your address:'
      expect(page).to have_content 'Please check your phone number:'
      expect(page).to have_content 'Pay'
    end
  end
end