FactoryBot.define do
  factory :category do
    name { generate :category_name }

    trait :invalid do
      name { nil }
    end
  end
end
