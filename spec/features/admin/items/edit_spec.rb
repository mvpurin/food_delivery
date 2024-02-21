require 'rails_helper'

feature 'Admin can edit items', '
  Authenticated user with admin role can edit items' do
    given(:category) { create(:category) }
    given!(:item) { create(:item, category: category) }

    describe 'Admin' do
      given(:admin) { create(:user, admin: true) }

      background do
        sign_in(admin)
        visit admin_category_path(category)
        click_on 'Edit'
      end

      scenario 'tries to edit item' do
        fill_in 'item[name]', with: 'Changed item name'
        click_on 'Create item'
        
        expect(page).to have_content 'Changed item name'
      end

      scenario 'tries to edit category with errors' do
        fill_in 'item[name]', with: ''
        click_on 'Create item'

        expect(page).to have_content "Name can't be blank"
      end
    end

    describe 'User' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
        visit category_path(category)
      end

      scenario 'tries to edit category' do
        expect(page).not_to have_content 'Edit'
      end
    end

    scenario 'Unauthenticated user tries to edit item' do
      visit category_path(category)
      expect(page).not_to have_content 'Edit'
    end
  end