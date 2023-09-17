FactoryBot.define do
  factory :answer do
    body { 'Answer body' }
    question { nil }
    author { create(:user) }

    trait :invalid_body do
      body { nil }
    end

    trait :with_comments do
      after(:create) do |answer|
        create_list(:comment, 1, commentable: answer)
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

    trait :with_links do
      after(:create) do |answer|
        create(:link, linkable: answer)
      end
    end

    trait :with_votes do
      after(:create) do |answer|
        create_list(:vote, 5, votable: answer)
      end
    end

    trait :with_comments do
      after(:create) do |answer|
        create_list(:comment, 1, commentable: answer)
      end
    end
  end
end
