require 'rails_helper'

describe 'user can vote for question', "
  In order to get vote for question
  As an authenticated user
  I'd like to be able to vote
" do
  describe 'Question' do
    let(:question) { create(:question) }
    let(:user) { create(:user) }

    before do
      login(user)
      visit question_path(question)
    end

    it 'Can change upvote', js: true do
      within('div[name="votes"]') do |node|
        click_on '+1'
        click_on '-1'
        expect(node).to have_content('Votes summary: -1')
      end
    end

    it 'Can chnage downvote', js: true do
      within('div[name="votes"]') do |node|
        click_on '-1'
        click_on '+1'
        expect(node).to have_content('Votes summary: 1')
      end
    end
  end

  describe 'Answer' do
    let(:question) { create(:question, :with_answers_and_votes) }
    let(:user) { question.author }

    before do
      login(user)
      visit question_path(question)
    end

    it 'Can change upvote', js: true do
      within('div[name="votes"]') do |node|
        click_on '+1'
        click_on '-1'
        expect(node).to have_content("Votes summary: #{question.answers.first.votes_sum}")
      end
    end

    it 'Can change downvote', js: true do
      within('div[name="votes"]') do |node|
        click_on '-1'
        click_on '+1'
        expect(node).to have_content("Votes summary: #{question.answers.first.votes_sum}")
      end
    end
  end
end
