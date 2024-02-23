require 'rails_helper'

feature 'User can add new comment', '
Authenticated user can add new comment
 to the order while confirming it' do
  describe 'User' do
    given(:user) { create(:user) }
    given!(:order) { create(:order, user: user, delivery_address: user.address,
      client_phone: user.phone_number) }

    background do
      sign_in(user)
      visit edit_order_path(order)
    end

    scenario 'tries to add new comment' do
      fill_in 'order[comment]', with: 'New comment'
      click_on 'Save'

      expect(page).to have_field('order[comment]', with: 'New comment')
    end
  end
end