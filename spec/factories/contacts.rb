FactoryBot.define do
  factory :contact do
    user { nil }
    fullname { "jose Gabriel" }
    birth_date { "1991/11/01" }
    phone { "(+57) 320-432-05-09" }
    address { "calle testing carrera drive number development" }
    credit_card { nil }
    sequence(:email) { |n| "test#{n}@example.com" }
  end
end
