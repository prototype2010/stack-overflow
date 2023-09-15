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

  describe 'GET /api/v1/questions/:id' do
    let(:question) { create(:question, :with_answers, :with_comments, :with_files, :with_link)}

    context 'unauthorized' do
      it_behaves_like 'API Authorizable' do
        let(:method) { :get }
        let(:params) { {id: question.id} }
      end
    end

    context 'authorized' do
      let(:user) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id).token}

      before do
        get "/api/v1/questions/#{question.id}", params: {access_token: access_token}, headers: headers
      end

      context 'Questions' do
        it 'returns successful status' do
          expect(response).to be_successful
        end

        it 'returns all public fields' do
          %w[id title body created_at updated_at ].each do |attr|
            expect(json['question'][attr]).to eq question.public_send(attr).as_json
          end
        end
      end

      context 'Links' do
        it 'returns array same size' do
          expect(json['question']['links'].size).to eq question.links.size
        end

        it 'returns all public fields' do
          %w[id name url].each do |attr|
            expect(json['question']['links'].first[attr])
              .to eq question.links.first.public_send(attr).as_json
          end
        end
      end

      context 'Comments' do
        it 'returns array same size' do
          expect(json['question']['comments'].size).to eq question.comments.size
        end

        it 'returns all public fields' do
          %w[id body].each do |attr|
            expect(json['question']['comments'].first[attr])
              .to eq question.comments.first.public_send(attr).as_json
          end
        end
      end

      context 'Files' do
        it 'returns array same size' do
          expect(json['question']['files'].size).to eq question.files.size
        end
      end

      context 'Author' do
        it 'returns all public fields' do
          %w[id email admin created_at updated_at].each do |attr|
            expect(json['question']['author'][attr])
              .to eq question.author.public_send(attr).as_json
          end
        end
      end


      context 'Answers' do
        it 'returns array same size' do
          expect(json['question']['answers'].size).to eq question.answers.size
        end

        it 'returns all public fields' do
          %w[id body author created_at updated_at comments].each do |attr|
            expect(json['question']['answers'].first[attr])
              .to eq question.answers.first.public_send(attr).as_json
          end
        end
      end
    end
  end
end

