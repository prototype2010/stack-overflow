class Api::V1::AnswersController < Api::V1::BaseController
  before_action :find_question

  def index
    if @question
      render json: @question.answers
    else
      not_found
    end
  end

  def show
    if @question
      Answer.find_by(question: @question, id: params[:id])
    else
      not_found
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end
