require 'rails_helper'

feature 'Admin can delete category', '
  Authenticated user with admin role can delete categories' do
    given!(:category) { create(:category) }

    describe 'Admin' do
      given(:admin) { create(:user, admin: true) }
      
      background do
        sign_in(admin)
        visit admin_categories_path
      end

      scenario 'tries to delete category' do
        click_on 'Delete'
        expect(page).not_to have_content category.name
      end
    end

    describe 'User' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
        visit categories_path
      end

      it 'tries to delete category' do
        expect(page).to_not have_content 'Delete'
      end
    end

    scenario 'Unauthenticated user tries to delete category' do
      visit categories_path
      expect(page).to_not have_content 'Delete'
    end
  end