module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def check_vote(new_value, author)
    existing_vote = votes.where(author: author).first

    if existing_vote
      existing_vote.update(value: new_value)
    else
      votes.create(author: author, value: new_value)
    end
  end

  def destroy_user_votes(current_user)
    votes.where(author: current_user).destroy_all
  end

  def votes_sum
    votes.sum(:value)
  end
end
