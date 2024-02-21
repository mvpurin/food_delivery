require 'rails_helper'

feature 'Admin can edit categories', '
  Authenticated user with admin role can edit categories' do
    given!(:category) { create(:category) }
    
    describe 'Admin' do
      given(:admin) { create(:user, admin: true) }

      background do
        sign_in(admin)
        visit admin_categories_path
        click_on 'Edit'
      end

      scenario 'tries to edit category' do
        fill_in 'category[name]', with: 'Changed category name'
        click_on 'Create category'

        expect(page).to have_content 'Changed category name'
      end

      scenario 'tries to edit category with errors' do
        fill_in 'category[name]', with: ''
        click_on 'Create category'

        expect(page).to have_content "Name can't be blank"
      end
    end

    describe 'User' do
      given(:user) { create(:user) }
      
      background do
        sign_in(user)
        visit categories_path
      end

      scenario 'tries to edit category' do
        expect(page).not_to have_content 'Edit'
      end
    end

    scenario 'Unauthenticated user tries to edit category' do
      visit categories_path
      expect(page).not_to have_content 'Edit'
    end
  end