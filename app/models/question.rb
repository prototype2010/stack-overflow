class Question < ApplicationRecord
  include Linkable
  include Rewardable
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true

  after_create :calculate_reputation

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end
end
