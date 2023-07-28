FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    question { nil }
    author { create(:user) }

    trait :invalid_body do
      body { nil }
    end
  end
end
