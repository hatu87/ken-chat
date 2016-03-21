class MessageMailer < ApplicationMailer
  def message_received_email(message, recipient = nil)
    @message = message
    @recipient = recipient
    # send mail to all recipients

    mail(to: recipient.email, subject: "You have received a message from #{@message.sender.name}")
  end

  def message_is_read_email(message, recipient)
    @message = message
    @recipient = recipient
    # send mail to all recipients

    mail(to: @message.sender.email, subject: "Your message has been read")
  end
end
