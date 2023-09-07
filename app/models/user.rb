class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]

  has_many :answers, foreign_key: :author_id, dependent: :destroy
  has_many :questions, foreign_key: :author_id, dependent: :destroy
  has_many :user_rewards, dependent: :destroy
  has_many :rewards, through: :user_rewards
  has_many :authorizations, dependent: :destroy
  has_many :comments, dependent: :destroy

  def self.from_omniauth(auth)
    FromOmniauth.new(auth).call
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end
