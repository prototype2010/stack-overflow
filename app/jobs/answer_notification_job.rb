class AnswerNotificationJob < ApplicationJob
  queue_as :default

  def perform(question)
    AnswerNotificationService.notify(question)
  end
end
