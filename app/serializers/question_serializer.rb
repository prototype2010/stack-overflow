class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at,
             :updated_at, :files, :comments, :links, :author_id

  has_many :answers, serializer: AnswerSerializer
  has_many :links
  has_many :comments
  has_many :files

  belongs_to :author
end
