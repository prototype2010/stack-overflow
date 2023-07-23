class AnswersController < ApplicationController
  before_action :load_question, only: %i[index show edit new create]
  before_action :load_answer, only: %i[destroy edit show update]

  def index
    @answers = @question.answers
  end

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to answer_path(@answer)
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to answer_path(@answer)
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_answers_path(@answer.question)
  end

  def show; end

  def new
    @answer = Answer.new
  end

  def edit; end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
