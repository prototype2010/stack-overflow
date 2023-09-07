module VotesHelper
  def can_vote?(record, user)
    user.present? && (user != record.author)
  end

  def upvoted?(record, user)
    vote = author_vote(record, user)
    return false unless vote

    vote.value == 1
  end

  def downvoted?(record, user)
    vote = author_vote(record, user)
    return false unless vote

    vote.value == -1
  end

  def deletable?(record, user)
    !(upvoted?(record, user) || downvoted?(record, user))
  end

  def author_vote(record, user)
    record.votes.where(author: user).first
  end
end
