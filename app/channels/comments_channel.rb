class CommentsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from("comments/#{data['questionId']}")
  end
end
