require 'rails_helper'

describe 'User can add links to question', "
  In order to provide additional info to my question
  As a question's author
  I'd like to be able to add links
" do
  let(:user) { create(:user) }
  let(:not_gist_url) { 'https://gist.github.com/prototype2010' }
  let(:gist_real_title) { 'Gist title' }
  let(:gist_url) { 'https://gist.github.com/prototype2010/b1a557f6172445fe3ec79b46ede4b626' }

  before do
    login(user)
    visit new_question_path

    fill_in 'Title', with: 'title'
    fill_in 'Body', with: 'body'
    click_on 'add link'
  end

  it 'User adds non-gist link when asks question', js: true do
    fill_in 'Name', with: 'Not gist'
    fill_in 'Url', with: not_gist_url
    click_on 'Ask'
    expect(page).to have_link 'Not gist', href: not_gist_url
  end

  it 'User adds gist link when asks question', js: true do
    fill_in 'Name', with: 'Not gist'
    fill_in 'Url', with: gist_url
    click_on 'Ask'

    within('#question_links') do |question_links|
      expect(question_links).to have_content gist_real_title
      expect(question_links).not_to have_content 'Not gist'
    end
  end
end
