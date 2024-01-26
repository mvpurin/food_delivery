require 'rails_helper'

describe 'User can create new category', '
  User can create new category with its name
' do
  describe 'User' do
    it 'creates new category' do
      visit new_category_path
      fill_in 'category[name]', with: 'New category name'
      click_on 'Create category'

      expect(page).to have_content 'New category was successfully created!'
    end

    it 'creates new category without name' do
      visit new_category_path
      fill_in 'category[name]', with: ''
      click_on 'Create category'

      expect(page).to have_content "Name can't be blank"
    end

    it 'creates new category with an existing name' do
      Category.create(name: 'New category name')

      visit new_category_path
      fill_in 'category[name]', with: 'New category name'
      click_on 'Create category'

      expect(page).to have_content 'Name has already been taken'
    end
  end
end
