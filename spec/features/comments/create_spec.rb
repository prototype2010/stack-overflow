require 'rails_helper'

describe 'user can delete own comment', "
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to delete own comment
" do
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_answers) }
  let(:comment_body) { 'Comment body' }

  describe 'Authenticated user' do
    before do
      login(user)
      visit question_path(question)
    end

    context 'question' do
      it 'deletes own comment', js: true do
        section_selector = "#comments_Question_#{question.id}"

        within(section_selector) do |node|
          fill_in 'New comment', with: comment_body
          click_on 'Create new comment'
          node.click_on 'Delete'
          expect(node).not_to have_content comment_body
        end
      end
    end

    context 'answer' do
      it 'leaves comment', js: true do
        section_selector = "#comments_Answer_#{question.answers.first.id}"

        within(section_selector) do |node|
          fill_in 'New comment', with: comment_body
          click_on 'Create new comment'
          node.click_on 'Delete'
          expect(node).not_to have_content comment_body
        end
      end
    end
  end
end
