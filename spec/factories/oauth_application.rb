FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { 'test' }
    redirect_uri { 'https://localhost:3000/' }
    uid { '12345678' }
    secret { '1234123123' }
  end
end
