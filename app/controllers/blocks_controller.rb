class BlocksController < ApplicationController
  def create
    # binding.pry
    blocked_user = User.find_by_id(params[:blocked_user_id])
    current_user.blocked_users << blocked_user

    redirect_to user_friends_path
  end

  def destroy

    block = Block.find_by_user_id_and_blocked_user_id(current_user_id, params[:blocked_user_id])
    block.destroy

    redirect_to user_friends_path
  end
end
