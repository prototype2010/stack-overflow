class VotesController < ApplicationController
  def create
    record.check_vote(params[:value], current_user)

    respond_to do |format|
      format.json { render json: vote_action_details }
    end
  end

  def destroy
    record.destroy_user_votes(current_user)

    respond_to do |format|
      format.json { render json: vote_action_details }
    end
  end

  private

  def vote_action_details
    {
      count: record.votes_sum,
      parent_class: record.class.name,
      parent_id: record.id,
      action: define_action_type
    }
  end

  def define_action_type
    case params[:value].to_i
    when 1
      :upvote
    when -1
      :downvote
    else
      :destroy
    end
  end

  def record
    params[:class].constantize.find(params[:parent_id])
  end
end
