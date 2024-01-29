FactoryBot.define do
  factory :item do
    name { generate :item_name }
    price { 1.5 }
    amount { 1 }
    additional_info { "MyText" }

    trait :invalid do
      name { nil }
      price { 0 }
      amount { -5 }
      additional_info { nil }
    end
  end
end
