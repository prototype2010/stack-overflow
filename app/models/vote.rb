class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :author, class_name: 'User'

  validates :value, numericality: { only_integer: true },
                    comparison: { greater_than_or_equal_to: -1, less_than_or_equal_to: 1, other_than: 0 }
end
