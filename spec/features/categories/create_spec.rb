require 'rails_helper'

feature 'User can create new category', '
  User can create new category with its name
' do
  given(:user) { create(:user) }

  describe 'User' do
    background { sign_in(user) }
    
    scenario 'creates new category' do
      visit new_category_path
      fill_in 'category[name]', with: 'New category name'
      click_on 'Create category'

      expect(page).to have_content 'New category was successfully created!'
    end

    scenario 'creates new category without name' do
      visit new_category_path
      fill_in 'category[name]', with: ''
      click_on 'Create category'

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'creates new category with an existing name' do
      Category.create(name: 'New category name')

      visit new_category_path
      fill_in 'category[name]', with: 'New category name'
      click_on 'Create category'

      expect(page).to have_content 'Name has already been taken'
    end
  end
end
