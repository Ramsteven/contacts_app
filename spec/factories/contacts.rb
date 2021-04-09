FactoryBot.define do
  factory :contact do
    user { nil }
    fullname { "MyString" }
    birth_date { "2021-04-08" }
    phone { "MyString" }
    address { "MyString" }
    credit_card { "MyString" }
    franchise { "MyString" }
    email { "MyString" }
  end
end
