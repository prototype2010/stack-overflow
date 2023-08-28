FactoryBot.define do
  factory :vote do
    value { 1 }
    author { create(:user) }

    trait :downvote do
      value { -1 }
    end
  end
end
