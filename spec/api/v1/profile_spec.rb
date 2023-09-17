require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) do
    { "CONTENT_TYPE": 'application/json',
      "ACCEPT": 'application/json' }
  end
  let(:api_path) { '/api/v1/profiles/me' }

  describe 'GET /api/v1/profiles/me' do
    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :get }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

      before { get api_path, params: { access_token: access_token }, headers: headers }

      it 'returns successful status' do
        expect(response).to be_successful
      end

      it 'returns all public fields' do
        %w[admin id email created_at updated_at].each do |attr|
          expect(json['user'][attr]).to eq user.public_send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json['user']).not_to have_key attr
        end
      end
    end
  end
end
