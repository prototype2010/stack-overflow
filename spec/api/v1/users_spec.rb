require 'rails_helper'

describe 'Users API', type: :request do
  let(:headers) {
    { "CONTENT_TYPE": 'application/json' ,
      "ACCEPT": 'application/json'  }
  }
  let(:api_path) {'/api/v1/users' }


  describe 'GET /api/v1/users' do
    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :get }
      end
    end

    context 'authorized' do
      let!(:users) { create_list(:user, 5) }
      let(:first_user) { users.first }
      let(:access_token) { create(:access_token, resource_owner_id: first_user.id).token}

      before { get '/api/v1/users' ,params: {access_token: access_token}, headers: headers }

      context 'Users' do
        it 'returns successful status' do
          expect(response).to be_successful
        end

        it 'returns array same size' do
          expect(json['users'].size).to eq users.size - 1
        end

        it 'returns all public fields' do
          %w[id email admin created_at updated_at].each do |attr|
            expect(json['users'].first[attr]).to eq users.second.public_send(attr).as_json
          end
        end
      end
    end
  end
end

