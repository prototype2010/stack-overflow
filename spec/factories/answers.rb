FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    question { nil }

    trait :invalid_body do
      body { nil }
    end
  end
end
