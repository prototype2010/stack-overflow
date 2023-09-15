class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at, :author, :comments
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
end
