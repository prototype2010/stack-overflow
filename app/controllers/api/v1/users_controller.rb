class Api::V1::UsersController < Api::V1::BaseController
  def index
    other_users = User.where.not(id: [current_resource_owner])
    
    render json: other_users
  end
end
