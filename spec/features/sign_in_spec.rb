require 'rails_helper'

feature 'User can sign in in the app', '
  User should be able to log in' do
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