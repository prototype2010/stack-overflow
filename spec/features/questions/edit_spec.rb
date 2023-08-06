require 'rails_helper'

describe 'user can edit my own question', "
  In order to edit question
  As an authenticated user
  I'd like to be able to edit my own question
" do
  let(:question) { create(:question) }

  describe 'Authenticated user' do
    before do
      login(question.author)
      visit questions_path
      click_on 'Edit'
    end

    it 'edits question', js: true do
      new_title = 'New title'
      new_body = 'New body'

      fill_in 'Title', with: new_title
      fill_in 'Body', with: new_body
      click_on 'Update question'

      within("#question_#{question.id}") do |node|
        expect(node).to have_content new_title
        expect(node).to have_content new_body
      end
    end

    it 'asks question with errors', js: true do
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''
      click_on 'Update question'

      expect(page).to have_content "Title can't be blank"
    end
  end

  it 'Unauthenticated user tries to edit a question' do
    visit questions_path

    expect(page).not_to have_content 'Edit'
  end
end
