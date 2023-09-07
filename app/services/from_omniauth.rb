class FromOmniauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authorization = Authorization.find_by(provider: auth.provider, uid: auth.uid.to_s)
    authorization.user if authorization

    email = auth.info[:email]
    user = User.find_by(email: email)

    if user
      user.create_authorization(auth) if user
      user
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password )
      user.create_authorization(auth)
      user
    end
  end
end
