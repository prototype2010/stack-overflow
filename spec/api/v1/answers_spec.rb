require 'rails_helper'

describe 'Question answers API', type: :request do
  let(:headers) do
    { "CONTENT_TYPE": 'application/json',
      "ACCEPT": 'application/json' }
  end
  let(:question) { create(:question, :with_answers) }

  let(:api_path) { api_v1_question_answers_path(question) }

  describe 'GET /api/v1/questions/:id/answers' do
    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :get }
        let(:params) { { id: question.id } }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

      before do
        get api_v1_question_answers_path(question), params: { access_token: access_token }, headers: headers
      end

      context 'Answers' do
        it 'returns array same size' do
          expect(json['answers'].size).to eq question.answers.size
        end

        it 'returns all public fields' do
          %w[id body created_at updated_at comments].each do |attr|
            expect(json['answers'].first[attr])
              .to eq question.answers.first.public_send(attr).as_json
          end
        end
      end
    end
  end
end
