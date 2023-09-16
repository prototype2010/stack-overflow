require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_many(:authorizations).dependent(:destroy) }

  describe 'OauthService' do
    let!(:user) { create(:user, email: 'test@gmail.com') }
    let(:auth) do
      OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'test@gmail.com' })
    end
    let(:service) { double('FromOmniauth') }

    it 'calls FromOmniauth' do
      expect(FromOmniauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.from_omniauth(auth)
    end
  end
end
