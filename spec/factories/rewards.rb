FactoryBot.define do
  factory :reward do
    description { 'Reward description' }
    image { Rack::Test::UploadedFile.new("#{Rails.root.join('spec/rails_helper.rb')}") }
  end
end
