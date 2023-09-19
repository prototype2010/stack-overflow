class Question < ApplicationRecord
  include Subscriptionable
  include Linkable
  include Rewardable
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true

  after_create :calculate_reputation
  after_create :subscribe_author_to_updates

  private
  #
  # def calculate_reputation
  #   ReputationJob.perform_later(self)
  # end

  def subscribe_author_to_updates
    self.subscriptions.create(user: author)
  end
end
