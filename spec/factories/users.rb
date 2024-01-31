FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name { "MyString" }
    email { generate :email }
    address { "MyString" }
    phone_number { "MyString" }
    password { '123456' }
    password_confirmation { '123456' }
    admin { false }
  end
end
