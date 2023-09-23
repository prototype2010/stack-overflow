class Answer < ApplicationRecord
  include Linkable
  include Votable
  include Commentable
  include PgSearch::Model
  multisearchable against: [:body]

  pg_search_scope :search,
                  using: [:tsearch],
                  against: [:body]

  before_update :set_best_answer
  after_create :notify_subscribers

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  private

  def notify_subscribers
    AnswerNotificationJob.perform_later(question)
  end

  def set_best_answer
    return unless best?

    unset_previous_best_answer
    set_reward
  end

  def unset_previous_best_answer
    question.answers.where.not(id: id).update_all(best: false)
  end

  def set_reward
    return unless question.reward.present?

    UserReward.where(reward: question.reward).destroy_all
    author.rewards << question.reward
  end
end
