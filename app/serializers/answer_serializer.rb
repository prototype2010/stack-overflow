class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at,
             :author, :comments, :files, :links, :author_id, :best, :question_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  # belongs_to :question, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :files
  has_many :links
end
