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

    it 'responds a question', js: true do
      response_text = 'response 1234'

      fill_in 'Respond', with: response_text
      click_on 'Publish response'

      visit question_path(question)

      expect(page).to have_content response_text
    end

    it 'responds a question and attaches files', js: true do
      response_text = 'response 1234'

      fill_in 'Respond', with: response_text
      attach_file 'Files', ["#{Rails.root.join('spec/rails_helper.rb')}", "#{Rails.root.join('spec/spec_helper.rb')}"]
      click_on 'Publish response'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    it 'asks question with errors', js: true do
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

  context 'Multiple sessions' do
    let(:response_text) { 'response 1234' }

    it 'created answer is visible for all users', js: true do
      Capybara.using_session('user') do
        login(user)
        visit question_path(question)
      end

      Capybara.using_session('guest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        fill_in 'Respond', with: response_text
        click_on 'Publish response'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content response_text
      end
    end
  end
end
