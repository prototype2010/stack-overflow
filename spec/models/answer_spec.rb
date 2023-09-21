require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { is_expected.to belong_to(:question) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to have_many(:links) }
  it { is_expected.to accept_nested_attributes_for(:links) }

  describe 'new answers notifications' do
    let(:question) { create(:question) }

    it 'call notifications job' do
      expect(AnswerNotificationJob).to receive(:perform_later).with(question)
      question.answers.create(body: 'something', author: create(:user))
    end
  end
end
