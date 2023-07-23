require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question, :with_answers) }
  let(:answers) { question.answers }

  describe 'GET #index' do
    before { get :index, params: { question_id: question.id } }

    it 'load all answers to the question' do
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'renders index' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:answer) { answers.first }

    before { get :show, params: { question_id: question.id, id: answer.id } }

    it 'assigns correct answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders proper template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    let(:answer) { answers.first }

    before { get :edit, params: { question_id: question.id, id: answer.id } }

    it 'assigns correct answer' do
      expect(assigns(:answer)).to eq(answer)
    end

    it 'renders proper template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question.id } }

    it 'assigns correct answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders proper template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, :with_answers) }

    it 'changes answers count' do
      expect { delete :destroy, params: { id: question.answers.first.id } }
        .to change(Answer, :count).by(-1)
    end

    it 'redirects to question answers' do
      delete :destroy, params: { id: question.answers.first.id }
    end
  end

  describe 'POST #create' do
    let!(:question) { create(:question, :with_answers) }
    let(:answer_attributes) { { answer: attributes_for(:answer) } }

    context 'with valid params' do
      it 'creates answer successfully' do
        expect { post :create, params: { question_id: question.id, **answer_attributes } }
          .to change(Answer, :count).by(1)
      end

      it 'redirects to new' do
        post :create, params: { question_id: question.id, **answer_attributes }

        expect(response).to redirect_to(assigns(:answer))
      end
    end

    context 'with invalid params' do
      let!(:question) { create(:question, :with_answers) }
      let(:answer_attributes) { { answer: attributes_for(:answer, :invalid_body) } }

      it 'does not create answer' do
        expect { post :create, params: { question_id: question.id, **answer_attributes } }
          .not_to change(Answer, :count)
      end

      it 'redirects to new' do
        post :create, params: { question_id: question.id, **answer_attributes }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:question) { create(:question, :with_answers) }
    let(:answer) { question.answers.first }
    let(:answer_attributes) { { body: 'new body' } }

    context 'with valid params' do
      before { patch :update, params: { id: answer.id, answer: answer_attributes } }

      it 'updates existing answer successfully' do
        expect(assigns(:answer)).to eq(answer)
      end

      it 'updates params successfully' do
        answer.reload
        expect(answer.body).to eq(answer_attributes[:body])
      end

      it 'redirects to answer show view' do
        expect(response).to redirect_to(assigns(:answer))
      end
    end

    context 'with invalid params' do
      let(:invalid_answer_attributes) { { body: nil } }
      let(:answer_attributes) { attributes_for(:answer) }

      before { patch :update, params: { id: answer.id, answer: invalid_answer_attributes } }

      it 'does not change answer' do
        answer.reload
        expect(answer.body).to eq(answer_attributes[:body])
      end

      it 'redirects to edit' do
        expect(response).to render_template(:edit)
      end
    end
  end
end
