require 'rails_helper'

feature 'User can create new item', '
  User can create new item with name, price and amount' do
    given(:user) { create(:user) }

    describe 'User' do
      background { sign_in(user) }
      let(:category) { create(:category) }

      scenario 'creates new item' do
        visit new_category_item_path(category)
        fill_in 'item[name]', with: 'New item title'
        fill_in 'item[additional_info]', with: 'Some info'
        fill_in 'item[price]', with: 10
        fill_in 'item[amount]', with: 100
        click_on 'Create item'

        expect(page).to have_content 'New item was successfully created!'
      end

      scenario 'creates new item with errors' do
        visit new_category_item_path(category)
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
  end