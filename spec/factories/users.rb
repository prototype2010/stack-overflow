FactoryBot.define do
  sequence :email do |n|
    "user#{n}@gmail.com"
  end

  factory :user do
    email
    password { '11111111' }
    password_confirmation { '11111111' }
  end
end
