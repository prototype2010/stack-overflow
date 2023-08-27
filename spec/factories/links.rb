FactoryBot.define do
  factory :link do
    name { 'Link to open' }
    url { 'https://www.youtube.com/' }

    trait :gist_url do
      url { 'https://gist.github.com/prototype2010/b1a557f6172445fe3ec79b46ede4b626' }
    end
  end
end
