require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { described_class.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { is_expected.to be_able_to :read, :all }
  end

  describe 'for admin' do
    let(:user) { create(:user, admin: true) }

    it { is_expected.to be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }

    it { is_expected.not_to be_able_to :manage, :all }
    it { is_expected.to be_able_to :read, :all }


    context 'Question' do
      let!(:question) { create(:question) }
      let!(:another_question) { create(:question) }
      let(:user) { question.author }

      it { is_expected.to be_able_to :create, Question }
      it { is_expected.to be_able_to :update, question }
      it { is_expected.to be_able_to :delete, question }
      it { is_expected.not_to be_able_to :update, another_question }
      it { is_expected.not_to be_able_to :delete, another_question }
    end

    context 'Answer' do
      let!(:question) { create(:question) }
      let!(:answer) { create(:answer, question: question) }
      let!(:another_answer) { create(:answer, question: question) }
      let(:user) { answer.author }

      it { is_expected.to be_able_to :create, Answer }
      it { is_expected.to be_able_to :update, answer }
      it { is_expected.to be_able_to :delete, answer }
      it { is_expected.not_to be_able_to :update, another_answer }
      it { is_expected.not_to be_able_to :delete, another_answer }
    end

    context 'Comment' do
      let!(:commentable) { create(:question) }
      let!(:comment) { create(:comment, commentable: commentable) }
      let!(:another_comment) { create(:comment, commentable: commentable) }
      let(:user) { comment.author }

      it { is_expected.to be_able_to :create, Comment }
      it { is_expected.to be_able_to :update, comment }
      it { is_expected.to be_able_to :delete, comment }
      it { is_expected.not_to be_able_to :delete, another_comment }
      it { is_expected.not_to be_able_to :update, another_comment }
      it { is_expected.not_to be_able_to :delete, another_comment }
    end
  end
end
