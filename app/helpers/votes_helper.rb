module VotesHelper
  def can_vote?(record)
    current_user.present? && (current_user != record.author)
  end

  def upvoted?(record)
    vote = author_vote(record)
    return false unless vote

    vote.value == 1
  end

  def downvoted?(record)
    vote = author_vote(record)
    return false unless vote

    vote.value == -1
  end

  def deletable?(record)
    !(upvoted?(record) || downvoted?(record))
  end

  def author_vote(record)
    record.votes.where(author: current_user).first
  end
end
