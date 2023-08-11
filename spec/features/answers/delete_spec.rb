require 'rails_helper'

describe 'user can delete their answers', "
  In order delete my own answer
  As an authenticated user
  I'd like to be able to delete my answer
" do
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_answers) }
  let(:answer_text) { 'some text' }

  before do
    login(user)
    visit question_path(question)
  end

  describe 'Sucessful delete' do
    it 'own answer can be deleted', js: true do
      fill_in 'Respond', with: answer_text
      click_on 'Publish response'
      click_on 'Delete'
      expect(page).not_to have_content answer_text
    end

    it 'Attachments can be deleted', js: true do
      fill_in 'Respond', with: answer_text
      attach_file 'Files', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb')}"]
      click_on 'Publish response'

      find_link(id: 'delete_attachment_rails_helper.rb').click
      find_link(id: 'delete_attachment_spec_helper.rb').click
      expect(page).not_to have_content 'rails_helper.rb'
      expect(page).not_to have_content 'spec_helper.rb'
    end
  end

  describe 'Unsuccessful delete' do
    it "delete is not available for some one else's answer" do
      expect(page).not_to have_content 'Delete'
    end
  end
end
