require 'rails_helper'

describe 'User can add reward to question', "
  In order to set reward to my question
  As a question's author
  I'd like to be able to add reward
" do
  let(:user) { create(:user) }

  it 'User can create reward' do
    login(user)
    visit new_question_path

    description = 'description'

    fill_in 'Title', with: 'title'
    fill_in 'Body', with: 'body'
    fill_in 'Description', with: description
    attach_file 'Image', "#{Rails.root.join('spec/rails_helper.rb')}"

    click_on 'Ask'
    within('#reward') do |reward_section|
      expect(reward_section).to have_content description
      expect(reward_section).to have_css('img[src$="rails_helper.rb"]')
    end
  end
end
