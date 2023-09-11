class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    proceed_oauth_response('Github')
  end

  def google_oauth2
    proceed_oauth_response('Google')
  end

  private

  def proceed_oauth_response(kind)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice,:success, kind: kind)
    else
      redirect_to root_path
    end
  end
end
