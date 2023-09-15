require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) {
    { "CONTENT_TYPE": 'application/json' ,
      "ACCEPT": 'application/json'  }
  }
  let(:api_path) {'/api/v1/profiles/me' }


  describe 'GET /api/v1/questions' do
    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :get }
      end
    end

    context 'authorized' do
      let!(:questions) { create_list(:question, 2) }
      let!(:first_question) { questions.first }
      let!(:answers) { create_list(:answer, 3, question: first_question) }
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token}

      before { get '/api/v1/questions',params: {access_token: access_token}, headers: headers }

      context 'Questions' do
        it 'returns successful status' do
          expect(response).to be_successful
        end

        it 'returns array same size' do
          expect(json['questions'].size).to eq questions.size
        end

        it 'returns all public fields' do
          %w[id title body].each do |attr|
            expect(json['questions'].first[attr]).to eq first_question.public_send(attr).as_json
          end
        end
      end

      context 'Answers' do
        it 'returns array same size' do
          expect(json['questions'].first['answers'].size).to eq answers.size
        end

        it 'returns all public fields' do
          %w[id body author created_at updated_at comments].each do |attr|
            expect(json['questions'].first['answers'].first[attr])
              .to eq answers.first.public_send(attr).as_json
          end
        end
      end
    end
  end
end

