require 'rails_helper'

feature 'Admin can delete item', '
  Authenticated user with admin role can delete items' do
    given(:category) { create(:category) }
    given!(:item) { create(:item, category: category) }

    describe 'Admin' do
      given(:admin) { create(:user, admin: true) }
      
      background do
        sign_in(admin)
        visit admin_category_path(category)
      end

      scenario 'tries to delete item' do
        click_on 'Delete'
        expect(page).not_to have_content item.name
      end
    end

    describe 'User' do
      given(:user) { create(:user) }

      background do
        sign_in(user)
        visit category_path(category)
      end

      it 'tries to delete category' do
        expect(page).to_not have_content 'Delete'
      end
    end

    scenario 'Unauthenticated user tries to delete category' do
      visit category_path(category)
      expect(page).to_not have_content 'Delete'
    end
  end