require 'rails_helper'

feature 'Admin can create new items', '
  Only authenticated user with admin role can create new items
' do
    describe 'Admin' do
      given(:admin) { create(:user, admin: true) }
      given!(:category) { create(:category) }

      background do
        sign_in(admin)
        click_on "#{category.name}"
        click_on 'Add new item'
      end
      
      scenario 'creates new item' do
        fill_in 'item[name]', with: 'New item title'
        fill_in 'item[additional_info]', with: 'Some info'
        fill_in 'item[price]', with: 10
        fill_in 'item[amount]', with: 100
        click_on 'Create item'

        expect(page).to have_content 'New item was successfully created!'
      end

      scenario 'creates new item with errors' do
        fill_in 'item[name]', with: ''
        fill_in 'item[additional_info]', with: ''
        fill_in 'item[price]', with: ''
        fill_in 'item[amount]', with: ''
        click_on 'Create item'

        expect(page).to have_content "Name can't be blank"
        expect(page).to have_content "Price can't be blank"
        expect(page).to have_content "Amount can't be blank"
        expect(page).to have_content "Additional info can't be blank"
        expect(page).to have_content "Price is not a number"
        expect(page).to have_content "Amount is not a number"
      end
    end

    describe 'User' do
      given(:user) { create(:user) }
      given(:category) { create(:category) }
      background { sign_in(user) }

      scenario 'tries to create new item' do
        visit new_admin_category_item_path(category)

        expect(page).to have_content 'Sorry, you are not authorized to view this page.'
      end
    end
  end