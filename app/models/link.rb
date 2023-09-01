class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :url, url: { schemes: %w[https http], public_suffix: true }
  validates :name, presence: true
end
