FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }

    trait :invalid_title do
      title { nil }
    end

    trait :invalid_body do
      body { nil }
    end

    trait :with_answers do
      after(:create) do |question|
        create_list(:answer, 2, question: question)
      end
    end
  end
end
