module SubscriptionsHelper
  def subscribed?(record, user)
    record.subscriptions.where(user: user).exists?
  end

  def unsubscribed?(record, user)
    !subscribed?(record, user)
  end
end
