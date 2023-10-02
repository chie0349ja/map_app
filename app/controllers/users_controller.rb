class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @spots = user.spots.order("created_at DESC")
  end
end
