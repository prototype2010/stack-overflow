class AnswersChannel < ApplicationCable::Channel
  def follow(data)
    stream_from("answers/#{data['questionId']}")
  end
end
