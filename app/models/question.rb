class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many_attached :files

  belongs_to :author, class_name: 'User'

  validates :title, presence: true
  validates :body, presence: true
end
