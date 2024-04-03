require 'rails_helper'

feature 'User or delivery person can sign in in the app', '
  User or delivery person should be able to log in' do
  describe 'User' do
    given(:user) { create(:user) }

    background { visit new_user_session_path }
      
    scenario 'Registered user tries to sign in' do
      fill_in 'Email', with: user.email 
      fill_in 'Password', with: user.password
      click_on 'Log in'

      expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'Unregistered user tries to sign in' do
      fill_in 'Email', with: 'wrong_email@email.com' 
      fill_in 'Password', with: 'wrong_password'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
    end
  end

  describe 'Delivery person' do
    given(:delivery_person) { create(:delivery_person) }

    background { visit new_delivery_person_session_path }
      
    scenario 'Registered delivery person tries to sign in' do
      fill_in 'Email', with: delivery_person.email 
      fill_in 'Password', with: delivery_person.password
      click_on 'Log in'

      expect(page).to have_content 'Signed in successfully.'
    end

    scenario 'Unregistered person tries to sign in' do
      fill_in 'Email', with: 'wrong_email@email.com' 
      fill_in 'Password', with: 'wrong_password'
      click_on 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
    end
  end
end