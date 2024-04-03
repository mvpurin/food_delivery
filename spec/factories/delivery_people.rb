FactoryBot.define do
  factory :delivery_person do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { generate :phone_number }
    email { generate :email }
    password { '123456' }
    password_confirmation { '123456' }
    status { 'free' }
  end
end
