class AnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(question)
    AnswerNotificationService.new.notify(question)
  end
end
