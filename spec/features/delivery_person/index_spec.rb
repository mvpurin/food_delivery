require 'rails_helper'

feature 'Delivery person can see his current order' do
  let(:user) { create(:user) }
  let(:delivery_person) { create(:delivery_person) }
  let(:delivery_person_2) { create(:delivery_person) }
  let(:category) { create(:category) }
  let(:item_1) { create(:item, category: category, amount: 100) }
  let(:item_2) { create(:item, category: category, amount: 200) }
  let(:order) { create(:order, user: user, delivery_person: delivery_person, delivery_address: user.address, client_phone: user.phone_number) }
  let!(:order_item_1) { create(:order_item, item: item_1, order: order, amount: 10) }
  let!(:order_item_2) { create(:order_item, item: item_2, order: order, amount: 20) }

  scenario 'Delivery person can see his current order if he has an order' do
    sign_in_courier(delivery_person)
    visit delivery_person_orders_path

    expect(page).to have_content order.delivery_address
    expect(page).to have_content order.client_phone
  end

  scenario 'Delivery person can not see order if he has not an order' do
    sign_in_courier(delivery_person_2)
    visit delivery_person_orders_path

    expect(page).to_not have_content order.delivery_address
    expect(page).to_not have_content order.client_phone
  end
end