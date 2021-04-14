FactoryBot.define do
  factory :fail_contact do
    message { "MyString" }
    fullname { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    address { "MyString" }
    birth_date { "MyString" }
    credit_card { "MyString" }
    user { nil }
    franchise { "MyString" }
  end
end
