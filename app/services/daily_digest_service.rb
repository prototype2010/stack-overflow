class DailyDigestService
  def send_digest
    User.find_each do |user|
      puts '###############'
      puts 'find each'
      puts user
      puts '###############'
      DailyDigestMailer.digest(user).deliver_now ##### HERE SHOULD BE DELIVER LATER WHEN  EVERYTHING WORKS FINE
    end
  end
end
