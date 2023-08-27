require 'rails_helper'

describe 'User can update reward on a question', "
  In order to update reward on my question
  As a question's author
  I'd like to be able to update reward
" do
  let!(:question) { create(:question) }

  it 'User can edit reward', js: true do
    login(question.author)
    visit questions_path
    click_on 'Edit'

    new_description = 'new description'

    fill_in 'Description', with: new_description
    attach_file 'Image', "#{Rails.root.join('spec/spec_helper.rb')}"

    click_on 'Update question'
    sleep 1
    visit question_path(question.id)

    within('#reward') do |reward_section|
      expect(reward_section).to have_content new_description
      expect(reward_section).to have_css('img[src$="spec_helper.rb"]')
    end
  end
end
