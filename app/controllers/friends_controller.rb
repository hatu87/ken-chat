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

  def destroy

    friend = Friend.find_by_user_id_and_friend_id(current_user_id, params[:friend_id])
    friend.destroy

    redirect_to user_friends_path
  end
end
