class DailyDigestMailer < ApplicationMailer
  def digest(user)
    @user = user
    puts '###############'
    puts 'MAILER  ###############################'
    puts user
    puts '###############'
    mail to: user.email
  end
end
