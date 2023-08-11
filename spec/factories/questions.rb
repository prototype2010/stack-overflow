FactoryBot.define do
  factory :question do
    title { 'Question title' }
    body { 'Question body' }
    author { create(:user) }

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

    trait :with_files do
      files do
        [
          Rack::Test::UploadedFile.new("#{Rails.root.join('spec/rails_helper.rb')}"),
          Rack::Test::UploadedFile.new("#{Rails.root.join('spec/spec_helper.rb')}")
        ]
      end
    end
  end
end
