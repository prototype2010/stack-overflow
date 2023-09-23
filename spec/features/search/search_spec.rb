require 'rails_helper'

RSpec.describe 'any user can search', "
  In order to get search results
  As any user
  I'd like to be able use search
" do

  let!(:question) { create(:question, :with_comments, :with_answers) }

  context 'global search' do
    before do
      visit root_path
      click_on 'Search'
    end

    it 'returns result by question title' do
      fill_in 'Search', with: question.title
      click_on 'Find'

      expect(page).to have_link question.title
    end

    it 'returns result by comment body' do
      fill_in 'Search', with: question.comments.first.body
      click_on 'Find'

      expect(page).to have_link question.comments.first.body
    end

    it 'returns result by answer body' do
      fill_in 'Search', with: question.answers.first.body
      click_on 'Find'

      expect(page).to have_link question.answers.first.body
    end

  end

  context 'entity search' do
    before do
      visit root_path
      click_on 'Search'
      uncheck 'Search everywhere'
      check 'Find in questions'
      check 'Find in answers'
      check 'Find in comments'
    end

    it 'returns result by question title' do
      fill_in 'Search', with: question.title
      click_on 'Find'

      expect(page).to have_link question.title
    end

    it 'returns result by comment body' do
      fill_in 'Search', with: question.comments.first.body
      click_on 'Find'

      expect(page).to have_link question.comments.first.body
    end

    it 'returns result by answer body' do
      fill_in 'Search', with: question.answers.first.body
      click_on 'Find'

      expect(page).to have_link question.answers.first.body
    end
  end
end
