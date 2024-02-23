require 'rails_helper'

feature 'User can pay for his order', '
Authenticated user can pay for his order' do
  describe 'User' do
    given(:user) { create(:user) }
    given!(:order) { create(:order, user: user, delivery_address: user.address,
      client_phone: user.phone_number) }

    background do
      sign_in(user)
      visit edit_order_path(order)
    end

    scenario 'tries to pay for his order' do
      click_on 'Pay'

      expect(page).to have_content 'Successfully payed!'
    end
  end
end