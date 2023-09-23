module SearchHelper
  def make_link_to_parent_question(record)
    case record
    when Comment
      make_comment_link(record)
    when Answer
      make_answer_link(record)
    when Question
      make_question_link(record)
    end
  end

  def make_comment_link(record)
    if record.commentable.is_a? Question
      link_to(record.body, question_path(record.commentable))
    else
      link_to(record.body, question_path(record.commentable.question))
    end
  end

  def make_answer_link(record)
    link_to(record.body, question_path(record.question))
  end

  def make_question_link(record)
    link_to(record.title, question_path(record))
  end
end
