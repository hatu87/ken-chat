class MessagesController < ApplicationController
  def index
    user = User.find(params[:user_id])
    logged_user = current_user

    @messages = user.received_messages.unread.recent
  end

  def sent
    user = User.find(params[:user_id])
    logged_user = current_user

    @messages = user.sent_messages.recent || []

  end

  def show
    @message = Message.find_by_id(params[:id])
    @message.update(read_at: Time.now)
  end
end
