FactoryBot.define do
  factory :answer do
    body { 'Answer body' }
    question { nil }
    author { create(:user) }

    trait :invalid_body do
      body { nil }
    end
  end
end
