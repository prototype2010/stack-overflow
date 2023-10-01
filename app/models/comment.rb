class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :author, class_name: 'User'
  include PgSearch::Model
  multisearchable against: [:body]

  pg_search_scope :search,
                  using: [:tsearch],
                  against: [:body]

  validates :body, presence: true

  after_save :update_search_indices

  def update_search_indices
    update_pg_search_document
  end
end
