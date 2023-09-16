require 'rails_helper'

describe 'User can sign in', "
  In order to ask question
  as an unathorized user
  I'd like to be able to sign in
" do
  let(:user) { User.create!(email: '1@gmail.com', password: '12345678') }

  before do
    visit new_user_session_path
  end

  it 'Registered user tries to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')
  end

  it 'Unregistered user tries to sign in' do
    fill_in 'Email', with: '2@gmail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end

  describe 'access via github' do
    it 'can sign in user with Github account' do
      visit new_user_session_path
      mock_github
      click_on 'Sign in with GitHub'
      expect(page).to have_content('Successfully authenticated from Github account.')
    end

    it 'can handle authentication error' do
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
      visit new_user_session_path
      click_on 'Sign in with GitHub'
      expect(page).to have_content('Could not authenticate you from GitHub because "Invalid credentials"')
    end
  end

  describe 'access via google' do
    it 'can sign in user with Google account' do
      visit new_user_session_path
      mock_google
      click_on 'Sign in with Google'
      expect(page).to have_content('Successfully authenticated from Google account.')
    end

    it 'can handle authentication error', js: true do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
      visit new_user_session_path
      click_on 'Sign in with GoogleOauth2'
      expect(page).to have_content('Could not authenticate you from GoogleOauth2 because "Invalid credentials"')
    end
  end
end
