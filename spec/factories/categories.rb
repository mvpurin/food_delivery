FactoryBot.define do
  # sequence :name do |n|
  #   "Category_name_#{n}"
  # end

  factory :category do
    name { generate :category_name }

    trait :invalid do
      name { nil }
    end
  end
end
