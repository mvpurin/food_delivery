FactoryBot.define do
  sequence :item_name do |n|
    "Item #{n}"
  end

  sequence :category_name do |n|
    "Category #{n}"
  end

  sequence :email do |n|
    "user#{n}@email.com"
  end

  sequence :phone_number do |n|
    "123456#{n}"
  end
end