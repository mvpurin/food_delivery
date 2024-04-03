require 'rails_helper'

feature 'User or delivery person can sign out', '
  Authenticated user or delivery person should be able to sign out' do
    describe 'User' do
      given(:user) { create(:user) }

      background { sign_in(user) }

      scenario 'Authenticated user tries to sign out' do
        click_on 'Sign out'

        expect(page).to have_content 'Signed out successfully.'
      end
    end

    describe 'Delivery person' do
      given(:delivery_person) { create(:delivery_person) }

      background { sign_in_courier(delivery_person) }

      scenario 'Authenticated user tries to sign out' do
        click_on 'Sign out'

        expect(page).to have_content 'Signed out successfully.'
      end
    end
  end