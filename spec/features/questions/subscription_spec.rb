require 'rails_helper'

describe 'User can subscribe to a question', "
  In order to provide beinformed about new answers
  As an authorized user
  I'd like to be able to subscribe to a question
" do
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_subscription) }

  context 'unsubscribe' do
    before do
      login(question.subscriptions.first.user)
    end

    it 'user can unsubscribe', js: true do
      visit question_path(question)

      expect(page).to have_content 'Unsubscribe'
    end
  end

  context 'subscribe' do
    before do
      login(user)
    end

    it 'author is subscrbed to oqn question by default', js: true do
      click_on 'Ask question'
      fill_in 'Title', with: 'title'
      fill_in 'Body', with: 'body'
      click_on 'Ask'

      expect(page).to have_content 'Unsubscribe'
    end

    it 'user can subscribe to question', js: true do
      visit question_path(question)
      click_on 'Subscribe'

      expect(page).to have_content 'Unsubscribe'
    end
  end
end
