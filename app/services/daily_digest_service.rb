class DailyDigestService
  def send_digest
    text = digest_text

    User.find_each do |user|
      DailyDigestMailer.digest(user, text).deliver_later
    end
  end

  private

  def digest_questions
    Question.where('created_at > :beginning_of_day', beginning_of_day: DateTime.now.beginning_of_day)
  end

  def digest_text
    digest_questions
      .map(&:title)
      .join('\n')
  end
end
