require 'rails_helper'

describe 'user can see questions', "
  In order to see questions
  As an user
  I'd like to be able to see questions
" do
  let!(:question) { create(:question, :with_answers) }

  describe 'Authenticated user' do
    it 'sees questions' do
      login(question.author)
      visit questions_path

      expect(page).to have_content question.body
      expect(page).to have_content question.title
    end
  end

  describe 'Unauthenticated user' do
    it 'sees questions' do
      visit questions_path

      expect(page).to have_content question.body
      expect(page).to have_content question.title
    end
  end
end
