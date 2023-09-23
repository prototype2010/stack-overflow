class Question < ApplicationRecord
  include Subscriptionable
  include Linkable
  include Rewardable
  include Votable
  include Commentable
  include PgSearch::Model
  multisearchable against: [:title, :body]

  pg_search_scope :search,
                  using: [:tsearch],
                  against: [:title, :body]

  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true

  after_create :subscribe_author_to_updates

  private

  after_save :update_search_indices

  def update_search_indices
    update_pg_search_document
  end

  def subscribe_author_to_updates
    self.subscriptions.create(user: author)
  end
end
