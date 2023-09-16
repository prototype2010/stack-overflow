require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Github' do
    let(:oauth_data) { { provider: 'github', 'uid': 123 } }

    it 'finds user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(User).to receive(:from_omniauth).with(oauth_data)
      get :github
    end

    context 'User exists' do
      let!(:user) { create(:user) }

      before do
        allow(User).to receive(:from_omniauth).and_return(user)
        get :github
      end

      it 'logins user' do
        expect(subject.current_user).to eq user
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'User does not exist' do
      before do
        allow(User).to receive(:from_omniauth)
        get :github
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
