class MessagesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    logged_user = current_user

    if current_user && user.id == logged_user.id
      # get current users messages
      @messages = user.received_messages.unread.recent
    else
      redirect_to root_path
    end
  end
end
