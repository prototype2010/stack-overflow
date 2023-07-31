require 'rails_helper'

describe 'user can create answer', "
  In order to respond to an existing question
  As an authenticated user
  I'd like to be able to respond the question
" do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'Authenticated user' do
    before do
      login(user)
      visit question_path(question)
    end

    it 'responds a question' do
      response_text = 'response 1234'

      fill_in 'Respond', with: response_text
      click_on 'Publish response'

      visit question_path(question)

      expect(page).to have_content response_text
    end

    it 'asks question with errors' do
      click_on 'Publish response'

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'Unathenticated user' do
    it 'responds to a question' do
      visit question_path(question)

      expect(page).not_to have_content 'Publish response'
    end
  end
end
