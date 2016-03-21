class MessagesController < ApplicationController
  before_action :require_message_recipient, only: [:index, :new, :show, :create]

  def require_message_recipient
    user_id = params[:user_id]
    # binding.pry

    unless user_id == current_user_id.to_s
      flash[:error] = "You don't have right to read this message."
      redirect_to login_path
    end
  end


  def index
    user = User.find(params[:user_id])
    logged_user = current_user
    @messages = Message.unread(user.id).recent
  end

  def sent
    user = User.find(params[:user_id])
    logged_user = current_user
    @messages = user.sent_messages.recent || []
  end

  def new
  end

  def show
    @message = Message.find_by_id(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def notify_message_read
    @message = Message.find_by_id(params[:message_id])
    @recipient = User.find_by_id(params[:recipient_id])

    if @message.unread?(@recipient.id)
      # @message.update(read_at: Time.now)
      @message.mark_as_read(@recipient.id)

      MessageMailer.message_is_read_email(@message, @recipient).deliver_now
    end
  end

  def create
    sender = current_user
    message = Message.new(message_params)
    sender.sent_messages << message

    if message.save
      # sent message successfully.
      # send mails
      message.recipients.each do |recipient|

        MessageMailer.message_received_email(message, recipient).deliver_now

      end
    else
      # sent message unsuccessfully.
      # Rails.logger.error 'Cannot send message'
      flash[:error] = 'Cannot send message to users'
    end
  end

  private
  def message_params
    params.require(:message).permit(:emails_string, :content)
  end
end
