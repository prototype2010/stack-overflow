FactoryBot.define do
  factory :answer do
    body { 'Answer body' }
    question { nil }
    author { create(:user) }

    trait :invalid_body do
      body { nil }
    end

    trait :with_votes do
      after(:create) do |question|
        create_list(:vote, 5, votable: question)
      end
    end
  end
end
