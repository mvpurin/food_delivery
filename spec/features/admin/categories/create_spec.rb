require 'rails_helper'

feature 'Admin can create new category', '
  Only authenticated user with admin role can create new category
' do
  describe 'Admin' do
    given(:admin) { create(:user, admin: true) }

    background do
      sign_in(admin)
      click_on 'Add new category'
    end

    scenario 'creates new category' do
      fill_in 'category[name]', with: 'New category name'
      click_on 'Create category'

      expect(page).to have_content 'New category was successfully created!'
    end

    scenario 'creates new category without name' do
      fill_in 'category[name]', with: ''
      click_on 'Create category'

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'creates new category with an existing name' do
      Category.create(name: 'New category name')

      fill_in 'category[name]', with: 'New category name'
      click_on 'Create category'

      expect(page).to have_content 'Name has already been taken'
    end
  end

  describe 'User' do
    given(:user) { create(:user) }

    background { sign_in(user) }
    
    scenario 'creates new category' do
      visit new_admin_category_path
 
      expect(page).to have_content 'Sorry, you are not authorized to view this page.'
    end
  end
end
