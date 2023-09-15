class Api::V1::AnswersController < Api::V1::BaseController
  def index
    render json: Question.find(params[:question_id])&.answers
  end
end
