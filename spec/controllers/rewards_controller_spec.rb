require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  let(:question) { create(:question, :with_reward, :with_answers) }
  let(:user) { question.answers.first.author }

  describe 'GET #index' do
    before do
      UserReward.new(user: user, reward: question.reward)
      login(user)
    end

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns received reward' do
      get :index
      expect(assigns(:rewards)).to match_array(UserReward.all)
    end
  end
end
