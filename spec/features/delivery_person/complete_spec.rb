require 'rails_helper'

feature 'Delivery person can mark an order as completed' do
  let(:user) { create(:user) }
  let(:delivery_person) { create(:delivery_person) }
  let(:category) { create(:category) }
  let(:item_1) { create(:item, category: category, amount: 100) }
  let(:item_2) { create(:item, category: category, amount: 200) }
  let!(:order) { create(:order, user: user, delivery_person: delivery_person, delivery_address: user.address, client_phone: user.phone_number) }

  scenario 'Delivery person can mark an order as completed' do
    sign_in_courier(delivery_person)
    visit delivery_person_orders_path
    click_on 'Complete order'

    visit delivery_person_orders_path
    expect(page).to_not have_content order.delivery_address
    expect(page).to_not have_content order.client_phone
  end
end