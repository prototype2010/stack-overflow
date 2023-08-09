require 'rails_helper'

describe 'user can delete their questions', "
  In order delete my own question
  As an authenticated user
  I'd like to be able to delete my question
" do
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_files) }
  let(:filenames) { question.files.map(&:filename) }

  context 'Question delete' do
    describe 'Sucessful delete' do
      it 'own question can be deleted', js: true do
        login(question.author)
        visit questions_path
        click_on 'Delete'
        expect(page).not_to have_content question.title
      end
    end

    describe 'Unsuccessful delete' do
      it "delete is not available for some one else's question" do
        login(user)
        visit questions_path
        expect(page).not_to have_content 'Delete'
      end
    end
  end

  context 'Attachment delete' do
    it 'own question can be deleted', js: true do
      login(question.author)
      visit question_path(question.id)

      filenames.each do |filename|
        find_link(id: "delete_attachment_#{filename}").click
        expect(page).not_to have_content filename
      end
    end
  end
end
