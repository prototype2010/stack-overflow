FactoryBot.define do
  factory :comment do
    body { 'Positive comment' }
    author { create(:user) }
  end
end
