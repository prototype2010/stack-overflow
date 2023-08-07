require 'rails_helper'

describe 'user can choose best answer', "
  In order to point the best answer
  As an authenticated user
  I'd like to be able set best answer
" do
  let(:question) { create(:question, :with_answers) }
  let(:best_answer) { question.answers.first }

  describe 'Authenticated user' do
    before do
      login(question.author)
      visit question_path(question)
    end

    it 'responds a question', js: true do
      within("#answer_#{best_answer.id}") do |node|
        node.click_on 'Set best'
      end

      within("#answer_#{best_answer.id}") do |node|
        expect(node).to have_content '[BEST ANSWER]'
      end
    end
  end

  describe 'Unathenticated user' do
    it 'responds to a question' do
      visit question_path(question)

      expect(page).not_to have_content 'Set best'
    end
  end
end
