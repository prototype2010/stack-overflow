class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question
  before_action :load_answer, only: %i[show create update destroy]

  def index
    if @question
      render json: @question.answers
    else
      not_found
    end
  end

  def show
    if @answer
      render json: @answer
    else
      not_found
    end
  end

  def create
    @answer = @question.answers.build(**answer_params, author: current_resource_owner)

    if @answer.save
      render json: @answer
    else
      unprocessable_entity(@answer)
    end
  end

  def update
    @answer.update(answer_params)

    if @answer.save
      render json: @answer
    else
      unprocessable_entity(@answer)
    end
  end

  def destroy
    @answer.destroy
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find_by(question: @question, id: params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :best, files: [], links_attributes: %i[name url id _destroy])
  end
end
