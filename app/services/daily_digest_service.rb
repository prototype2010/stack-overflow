class DailyDigestService
  def send_digest
    text = digest_text

    User.find_each do |user|
      DailyDigestMailer.digest(user, text).deliver_now ##### HERE SHOULD BE DELIVER LATER WHEN  EVERYTHING WORKS FINE
    end
  end

  private

  def digest_questions
    Question.where('created_at > :beginning_of_day', beginning_of_day: DateTime.now.beginning_of_day)
  end

  def digest_text
    "<ul>
      #{digest_questions
               .map { |question| "<li>#{question.title}</li></br>" }
               .join('')
      }
    </ul>"
      .html_safe
  end

end
