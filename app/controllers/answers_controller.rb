class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[destroy edit update]
  after_action :publish_answer, only: %i[create]

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

  def edit; end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find_by(id: params[:id])
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast("answers/#{@question.id}",
                                 ApplicationController.render(partial: 'answers/answer', locals: {
                                                                answer: @answer,
                                                                user: current_user
                                                              }))
  end

  def answer_params
    params.require(:answer).permit(:body, :best, files: [], links_attributes: %i[name url id _destroy])
  end
end
