FactoryBot.define do
  factory :order do
    total_price { 0.0 }
    status { "MyString" }
    payment_method { "MyString" }
  end
end
