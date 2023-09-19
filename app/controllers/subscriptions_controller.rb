class SubscriptionsController < ApplicationController
  def create
    destroy_existing

    record.subscriptions.create(user: current_user)
  end

  def destroy
    destroy_existing
  end

  private

  def destroy_existing
    record.subscriptions.where(user: current_user).destroy_all
  end

  def record
    @record ||= params[:class].constantize.find(params[:parent_id])
  end
end
