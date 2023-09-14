require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) {
    { "CONTENT_TYPE": 'application/json' ,
      "ACCEPT": 'application/json'  }
  }

  describe 'GET /api/v1/profiles/me' do
    context 'unauthorized' do
      it 'with no access token' do
        get '/api/v1/profiles/me', headers: headers
        expect(response.status).to eq 401
      end

      it 'with invalid access token' do
        get '/api/v1/profiles/me',params: {access_token: '1234'}, headers: headers
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token}

      before { get '/api/v1/profiles/me',params: {access_token: access_token}, headers: headers }

      it 'returns successful status' do
        expect(response).to be_successful
      end

      it 'returns all public fields' do
        %w[admin id email created_at updated_at].each do |attr|
          expect(json[attr]).to eq user.public_send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key attr
        end
      end

    end
  end
end
