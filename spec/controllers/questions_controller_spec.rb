require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { question.author }
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'loads all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index' do
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns proper question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    before do
      login(user)
      get :edit, params: { id: question }, xhr: true
    end

    it 'assigns proper question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'GET #new' do
    before do
      login(user)
      get :new
    end

    it 'creates new Question instance' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'creates new Reward instance' do
      expect(assigns(:question).reward).to be_a_new(Reward)
    end

    it 'render new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'creates questions successfully' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to view after create' do
        post :create, params: { question: attributes_for(:question) }

        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not create question with invalid title' do
        expect { post :create, params: { question: attributes_for(:question, :invalid_title) } }
          .not_to change(Question, :count)
      end

      it 'does not create question with invalid body' do
        expect { post :create, params: { question: attributes_for(:question, :invalid_body) } }
          .not_to change(Question, :count)
      end

      it 'does not create question with invalid body' do
        post :create, params: { question: attributes_for(:question, :invalid_body) }

        expect(response).to render_template(:new)
      end

      it 'does not create question with invalid title' do
        post :create, params: { question: attributes_for(:question, :invalid_title) }

        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:question) { create(:question) }

    it 'changes question count' do
      expect { delete :destroy, params: { id: question }, xhr: true }.to change(Question, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: { id: question }, xhr: true
      expect(response).to render_template(:destroy)
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'assigns requested question to question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, xhr: true
        expect(assigns(:question)).to eq(question)
      end

      it 'changes question parameters' do
        new_params = { title: 'new title', body: 'new body' }
        patch :update, params: { id: question, question: new_params }, xhr: true

        question.reload
        expect(question.title).to eq(new_params[:title])
        expect(question.body).to eq(new_params[:body])
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update, params:
        { id: question, question: attributes_for(:question, :invalid_title) }, xhr: true
      end

      it 'does not change question' do
        default_factory_attrs = attributes_for(:question)
        question.reload

        expect(question.title).to eq(default_factory_attrs[:title])
        expect(question.body).to eq(default_factory_attrs[:body])
      end

      it 're-renders edit' do
        expect(response).to render_template(:update)
      end
    end
  end
end
