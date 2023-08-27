class Reward < ApplicationRecord
  has_one :user_reward, dependent: :destroy

  belongs_to :rewardable, polymorphic: true

  has_one_attached :image
  validates :description, presence: true
end
