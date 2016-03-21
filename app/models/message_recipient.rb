class MessageRecipient < ActiveRecord::Base
  belongs_to :recipient, class_name: :User
  belongs_to :message
end
