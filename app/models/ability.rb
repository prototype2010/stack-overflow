# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
    can :create, :all
  end

  def user_abilities
    guest_abilities
    can :create,[Question, Answer, Comment]

    can :update, Answer do |answer|
      answer.question.author == user || answer.author == user
    end

    can :manage, Comment do |comment|
      commentable = comment.commentable

      if commentable.is_a? Question
        commentable.author == user
      elsif commentable.is_a? Answer
        commentable.question.author == user
      end
    end

    can :manage, [Question, Answer, Comment], author_id: user.id
  end
end
