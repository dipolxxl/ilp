class UsersController < ApplicationController
  def index
    users = User.select([:id, :name, :balance]).order(:id)
    render json: users
  end
end
