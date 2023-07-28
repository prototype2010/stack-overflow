require 'rails_helper'

describe 'user can create question', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
" do
  let(:user) { create(:user) }

  describe 'Authenticated user' do
    before do
      login(user)
      visit questions_path
      click_on 'Ask question'
    end

    it 'asks question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
    end

    it 'asks question with errors' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
    end
  end

  it 'Unauthenticated user tries to ask a question' do
    visit questions_path

    expect(page).not_to have_content 'Ask question'
  end
end
