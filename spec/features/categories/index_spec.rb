require 'rails_helper'

describe 'User can see list of categories', '
  User can see list of all existing categories
' do
  let!(:category) { create(:category) }

  it 'User can see list of categories' do
    visit categories_path

    expect(page).to have_content category.name
  end
end
