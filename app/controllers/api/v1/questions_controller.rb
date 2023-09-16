class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :load_question, only: %i[edit show update destroy]

  def index
    render json: Question.all
  end

  def show
    render json: Question.find(params[:id])
  end

  def update
    if @question.update(question_params)
      render json: @question
    else
      unprocessable_entity(@question)
    end
  end

  def destroy
    @question.destroy
  end

  def create
    @question = Question.new(**question_params, author: current_resource_owner)

    if @question.save
      render json: @question
    else
      unprocessable_entity(@question)
    end
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title,
                                     :body,
                                     files: [],
                                     links_attributes: %i[name url id _destroy],
                                     reward_attributes: %i[description image])
  end
end
