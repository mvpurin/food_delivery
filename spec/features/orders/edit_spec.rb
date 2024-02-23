require 'rails_helper'

feature 'User can edit his order', '
Authenticated user can edit his address and phone number
 and add new comment while confirming his order' do
  describe 'User' do
    given(:user) { create(:user) }
    given!(:order) { create(:order, user: user, delivery_address: user.address,
      client_phone: user.phone_number) }

    background do
      sign_in(user)
      visit edit_order_path(order)
    end

    scenario 'tries to edit his address and phone number' do
      fill_in 'order[delivery_address]', with: 'Edited address'
      fill_in 'order[client_phone]', with: '123'
      click_on 'Save'

      expect(page).to have_field('order[delivery_address]', with: 'Edited address')
      expect(page).to have_field('order[client_phone]', with: '123')
    end

    scenario 'tries to edit with errors' do
      fill_in 'order[delivery_address]', with: ''
      fill_in 'order[client_phone]', with: ''
      click_on 'Save'

      expect(page).to have_content "Delivery address can't be blank"
      expect(page).to have_content "Client phone can't be blank"
    end
  end
end