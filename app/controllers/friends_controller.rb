class FriendsController < ApplicationController
  def index
    @friends = User.except_current(current_user_id)
  end

  def create
    # binding.pry
    friend = User.find_by_id(params[:friend_id])
    current_user.friends << friend

    redirect_to user_friends_path
  end
end
