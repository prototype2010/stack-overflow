class Answer < ApplicationRecord
  before_update :set_best_answer

  has_many :links, dependent: :destroy, as: :linkable
  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true

  private

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
    self.author.rewards << question.reward
  end
end
