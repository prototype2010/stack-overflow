class Answer < ApplicationRecord
  before_update :check_best_answer

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  private

  def check_best_answer
    return unless best?

    question.answers.where.not(id: id).update_all(best: false)
  end
end
