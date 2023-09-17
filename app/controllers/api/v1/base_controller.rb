class Api::V1::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :doorkeeper_authorize!

  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def unprocessable_entity(entity)
    status 422
    render json: entity.errors.full_messages
  end

  def not_found
    status 404
    render json: :not_found
  end
end
