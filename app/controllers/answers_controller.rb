class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :load_question, only: %i[show create]
  before_action :load_answer, only: %i[destroy edit show update]

  def create
    @answer = @question.answers.build(**answer_params, author: current_user)
    @answer.save
  end

  def update
    @answer.update(answer_params)
    @answer.save

    respond_to do |format|
      format.html { redirect_to question_path(@answer.question) }
      format.js
    end
  end

  def destroy
    @answer.destroy
  end

  def show; end

  def edit; end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :best)
  end
end
