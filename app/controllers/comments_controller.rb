class CommentsController < ApplicationController
  after_action :publish_answer, only: %i[create]

  def create
    @comment = record.comments.build(body: params[:body], author: current_user)
  end

  def destroy
    @comment = Comment.find_by(author: current_user, id: params[:id])
    @comment.destroy
  end

  private

  def publish_answer
    return if @comment.errors.any?

    ActionCable.server.broadcast("comments/#{comment_question.id}", {
                                   data: comment_markup,
                                   record_id: @comment.commentable.id,
                                   record_class: @comment.commentable.class.name
                                 })
  end

  def comment_markup
    ApplicationController.render(partial: 'comments/comment',
                                 locals: {
                                   resource: @comment,
                                   user: current_user
                                 })
  end

  def comment_question
    record.instance_of?(Question) ? record : record.question
  end

  def record
    params[:class].constantize.find(params[:parent_id])
  end
end
