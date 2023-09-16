require 'rails_helper'

describe 'Answer API', type: :request do
  let(:headers) do
    { "ACCEPT": 'application/json' }
  end
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, :with_comments, :with_links, :with_files, question: question) }

  describe 'GET /api/v1/questions/:question_id/answers/:id' do
    let(:api_path) { api_v1_question_answer_path(question, answer) }

    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :get }
        let(:params) { { question_id: question.id } }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

      before do
        get api_path,
            params: { access_token: access_token }, headers: headers
      end

      context 'Answer' do
        it 'returns all public fields' do
          %w[id body created_at updated_at comments files links].each do |attr|
            expect(json['answer'][attr])
              .to eq answer.public_send(attr).as_json
          end
        end
      end
    end
  end

  describe 'POST /api/v1/questions/:question_id/answers' do
    let(:api_path) { api_v1_question_answers_path(question) }
    let(:answer_params) { create(:answer) }

    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :post }
        let(:params) { { question_id: question.id } }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

      before do
        post(api_path,
             params: { access_token: access_token, answer: { body: answer.body } },
             headers: headers)
      end

      it 'Response should be successful' do
        expect(response).to be_successful
      end

      it 'Body should match' do
        expect(json['answer']['body']).to eq answer.body
      end
    end
  end

  describe 'PATCH /api/v1/questions/:question_id/answers/:id' do
    let(:api_path) { api_v1_question_answer_path(question, answer) }

    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :patch }
        let(:params) { { question_id: question.id, id: answer.id } }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

      before do
        patch(api_path,
              params: { access_token: access_token, answer: { body: answer.body } },
              headers: headers)
      end

      it 'Response should be successful' do
        expect(response).to be_successful
      end

      it 'Body should match' do
        expect(json['answer']['body']).to eq answer.body
      end
    end
  end

  describe 'DELETE /api/v1/questions/:question_id/answers/:id' do
    let(:api_path) { api_v1_question_answer_path(question, answer) }

    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :delete }
        let(:params) { { question_id: question.id, id: answer.id } }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token }

      before do
        delete(api_path, params: { access_token: access_token }, headers: headers)
      end

      it 'Response should be successful' do
        expect(response).to be_successful
      end
    end
  end
end
