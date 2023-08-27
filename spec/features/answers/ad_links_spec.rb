require 'rails_helper'

describe 'User can add links to answer', "
  In order to provide additional info to my answer
  As a answer's author
  I'd like to be able to add links
" do
  let(:question) { create(:question) }
  let(:user) { create(:user) }
  let(:not_gist_url) { 'https://gist.github.com/prototype2010' }
  let(:gist_real_title) { 'Gist title' }
  let(:gist_url) { 'https://gist.github.com/prototype2010/b1a557f6172445fe3ec79b46ede4b626' }

  before do
    login(user)
    visit question_path(question)
    fill_in 'Respond', with: 'any'
    click_on 'add link'
  end

  it 'User adds link when asks question', js: true do
    fill_in 'Name', with: 'Not gist'
    fill_in 'Url', with: not_gist_url

    click_on 'Publish response'

    expect(page).to have_link 'Not gist', href: not_gist_url
  end

  it 'User adds gist when asks question', js: true do
    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Publish response'

    within('.answers') do |answers|
      expect(answers).to have_content gist_real_title
      expect(answers).not_to have_content 'My gist'
    end
  end
end
