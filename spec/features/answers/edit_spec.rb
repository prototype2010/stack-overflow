require 'rails_helper'

describe 'user can edit answer', "
  In order to respond to an existing question
  As an authenticated user
  I'd like to be able to respond the question
" do
  let!(:question) { create(:question, :with_answers) }
  let!(:answer_to_edit) { question.answers.first }

  describe 'Authenticated user' do
    before do
      login(answer_to_edit.author)
      visit question_path(question)

      within("#answer_#{answer_to_edit.id}") do |node|
        node.click_on 'Edit'
      end
    end

    it 'responds a question', js: true do
      new_answer_text = 'response 1234'

      within("#edit_form_#{answer_to_edit.id}") do |node|
        node.fill_in 'Respond', with: new_answer_text
        node.click_on 'Update response'
      end

      within("#answer_#{answer_to_edit.id}") do |node|
        expect(node).to have_content new_answer_text
      end
    end

    it 'responds a question and attaches files', js: true do
      new_answer_text = 'response 1234'

      within("#edit_form_#{answer_to_edit.id}") do |node|
        node.fill_in 'Respond', with: new_answer_text
        node.attach_file 'Files',
                         ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb')}"]
        node.click_on 'Update response'
      end

      click_on 'Publish response'

      within("#answer_#{answer_to_edit.id}") do |node|
        expect(node).to have_link 'rails_helper.rb'
        expect(node).to have_link 'spec_helper.rb'
      end
    end

    it 'edits question with errors', js: true do
      within("#edit_form_#{answer_to_edit.id}") do |node|
        node.fill_in 'Respond', with: ''
        node.click_on 'Update response'
      end

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
