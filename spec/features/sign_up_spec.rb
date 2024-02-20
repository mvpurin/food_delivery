require 'rails_helper'

feature 'User can sign up to the app', '
  New user should be able to sign up' do
    background { visit new_user_registration_path }

    scenario 'New user tries to sign up' do
      fill_in 'First name', with: 'name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Phone number', with: '12345'
      fill_in 'Address', with: 'address'
      fill_in 'Email', with: 'test@email.com'
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
      click_on 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    scenario 'New user tries to sign up with errors' do
      fill_in 'First name', with: 'name'
      fill_in 'Last name', with: 'last name'
      fill_in 'Phone number', with: '12345'
      fill_in 'Address', with: 'address'
      fill_in 'Email', with: ''
      fill_in 'Password', with: '123456789'
      fill_in 'Password confirmation', with: '123456789'
      click_on 'Sign up'

      expect(page).to have_content "Email can't be blank"
    end
  end