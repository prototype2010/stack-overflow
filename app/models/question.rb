class Question < ApplicationRecord
  include Linkable
  include Rewardable
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy

  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true
end
