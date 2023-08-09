class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[edit show update destroy purge_attachment]

  def index
    @questions = Question.all
  end

  def show; end

  def edit; end

  def new
    @question = Question.new
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

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end
end
