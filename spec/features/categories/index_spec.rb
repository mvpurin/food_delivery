require 'rails_helper'

feature 'User can see list of categories', '
  User can see list of all existing categories
' do
  let!(:category) { create(:category) }

  scenario 'User can see list of categories' do
    visit categories_path

    expect(page).to have_content category.name
  end
end
