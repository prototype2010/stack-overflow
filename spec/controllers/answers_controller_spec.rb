require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { answers.first.author }
  let(:question) { create(:question, :with_answers) }
  let(:answers) { question.answers }

  describe 'GET #edit' do
    let(:answer) { answers.first }

    before do
      login(user)
      get :edit, params: { question_id: question.id, id: answer.id }, xhr: true
    end

    it 'assigns correct answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders proper template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, :with_answers) }

    before { login(question.answers.first.author) }

    it 'changes answers count' do
      expect { delete :destroy, params: { id: question.answers.first.id }, xhr: true }
        .to change(Answer, :count).by(-1)
    end

    it 'redirects to question answers' do
      delete :destroy, params: { id: question.answers.first.id }, xhr: true

      expect(response).to render_template(:destroy)
    end
  end

  describe 'POST #create' do
    let!(:question) { create(:question, :with_answers) }
    let(:answer_attributes) { { answer: attributes_for(:answer) } }

    before { login(user) }

    context 'with valid params' do
      it 'creates answer successfully' do
        expect { post :create, params: { question_id: question.id, **answer_attributes }, xhr: true }
          .to change(Answer, :count).by(1)
      end

      it 'renders create  template' do
        post :create, params: { question_id: question.id, **answer_attributes }, xhr: true

        expect(response).to render_template(:create)
      end
    end

    context 'with invalid params' do
      let!(:question) { create(:question, :with_answers) }
      let(:answer_attributes) { attributes_for(:answer, :invalid_body) }

      it 'does not create answer' do
        expect { post :create, params: { question_id: question.id, answer: answer_attributes }, xhr: true }
          .not_to change(Answer, :count)
      end

      it 'redirects to question path' do
        post :create, params: { question_id: question.id, answer: answer_attributes }, xhr: true

        expect(response).to render_template(:create)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:question) { create(:question, :with_answers) }
    let(:answer) { question.answers.first }
    let(:answer_attributes) { { body: 'new body' } }

    before { login(user) }

    context 'with valid params' do
      before { patch :update, params: { id: answer.id, answer: answer_attributes }, xhr: true }

      it 'updates existing answer successfully' do
        expect(assigns(:answer)).to eq(answer)
      end

      it 'updates params successfully' do
        answer.reload
        expect(answer.body).to eq(answer_attributes[:body])
      end

      it 'redirects to answer show view' do
        expect(response).to render_template(:update)
      end
    end

    context 'with invalid params' do
      let(:invalid_answer_attributes) { { body: nil } }
      let(:answer_attributes) { attributes_for(:answer) }

      before { patch :update, params: { id: answer.id, answer: invalid_answer_attributes }, xhr: true }

      it 'does not change answer' do
        answer.reload
        expect(answer.body).to eq(answer_attributes[:body])
      end

      it 'redirects to edit' do
        expect(response).to render_template(:update)
      end
    end
  end
end
