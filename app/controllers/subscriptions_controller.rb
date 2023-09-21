class SubscriptionsController < ApplicationController
  before_action :find_record

  def create
    if @record
      destroy_existing
      @record.subscriptions.create(user: current_user)
    else
      status 404
      render plain: 'Record not found'
    end
  end

  def destroy
    if @record
      destroy_existing
    else
      status 404
      render plain: 'Record not found'
    end
  end

  private

  def destroy_existing
    @record.subscriptions.where(user: current_user).destroy_all
  end

  def find_record
    klass = params[:class].constantize

    return unless klass.include? Subscriptionable

    @record ||= klass.find(params[:parent_id])
  end
end
