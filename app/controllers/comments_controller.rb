class CommentsController < ApplicationController
  def create
    @comment = record.comments.build(body: params[:body], author: current_user)
  end

  def destroy
    @comment = Comment.find_by(author: current_user, id: params[:id])
    @comment.destroy
  end

  private

  def record
    params[:class].constantize.find(params[:parent_id])
  end
end
