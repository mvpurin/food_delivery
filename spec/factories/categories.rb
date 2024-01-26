FactoryBot.define do
  factory :category do
    name { "MyString" }

    trait :invalid do
      name { nil }
    end
  end
end
