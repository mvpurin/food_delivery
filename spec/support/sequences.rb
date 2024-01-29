FactoryBot.define do
  sequence :item_name do |n|
    "Item #{n}"
  end

  sequence :category_name do |n|
    "Category #{n}"
  end
end