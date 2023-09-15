class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at
  has_many :answers, serializer: AnswerSerializer
  belongs_to :author
end
