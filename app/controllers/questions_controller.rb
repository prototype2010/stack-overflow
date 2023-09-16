class QuestionsController < ApplicationController
  before_action :load_question, only: %i[edit show update destroy purge_attachment]
  after_action :publish_question, only: %i[create]

  authorize_resource

  def index
    @questions = Question.all
  end

  def show
    @question.answers.new
    @answer = @question.answers.build
  end

  def edit; end

  def new
    @question = Question.new
    @question.reward = Reward.new
  end

  def update
    @question.update(question_params)
    @question.save
  end

  def destroy
    @question.destroy
  end

  def create
    @question = Question.new(**question_params, author: current_user)

    if @question.save
      redirect_to @question, notice: 'Your question successfully created'
    else
      render :new
    end
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast('questions',
                                 ApplicationController.render(partial: 'questions/question',
                                                              locals: {
                                                                question: @question,
                                                                current_user: current_user
                                                              }))
  end

  def question_params
    params.require(:question).permit(:title,
                                     :body,
                                     files: [],
                                     links_attributes: %i[name url id _destroy],
                                     reward_attributes: %i[description image])
  end
end
