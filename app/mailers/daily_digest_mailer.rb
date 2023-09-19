class DailyDigestMailer < ApplicationMailer
  def digest(user, text)
    @user = user
    @text = text
    mail to: user.email
  end
end
