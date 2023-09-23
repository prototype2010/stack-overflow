class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: 'User'
  include PgSearch::Model
  multisearchable against: [:body]

  pg_search_scope :search,
                  using: [:tsearch],
                  against: [:body]

  validates :body, presence: true
end
