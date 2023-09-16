require 'rails_helper'

RSpec.describe FromOmniauth do
  let!(:user) { create(:user, email: 'test@gmail.com') }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'github', uid: '123456', info: { email: 'test@gmail.com' }) }
  let(:subject) { described_class.new(auth) }

  context 'user already has authorization' do
    it 'returns user' do
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
      expect(subject.call).to eq user
    end
  end

  context 'user does not have authorization' do
    context 'user already exist' do
      let(:auth) do
        OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email })
      end

      it 'does not create new user' do
        expect { subject.call }.not_to change(User, :count)
      end

      it 'creates authorization for user' do
        expect { subject.call }.to change(user.authorizations, :count).by(1)
      end

      it 'creates authorization with provider and uid' do
        user = subject.call
        authorization = user.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end

      it 'returns the user' do
        expect(subject.call).to eq user
      end
    end

    context 'user does not exist' do
      let(:auth) do
        OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'some@gmail.com' })
      end

      it 'creates user ' do
        expect { subject.call }.to change(User, :count).by(1)
      end

      it 'returns new user' do
        expect(subject.call).to be_a(User)
      end

      it 'fills user email' do
        user =  subject.call
        expect(user.email).to eq auth.info.email
      end

      it 'creates authorization for user' do
        user = subject.call
        expect(user.authorizations).not_to be_empty
      end

      it 'creates authorization with provider and uid' do
        authorization = subject.call.authorizations.first
        expect(authorization.uid).to eq auth.uid
      end
    end
  end
end
