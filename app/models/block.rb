class Block < ActiveRecord::Base
  belongs_to :user
  belongs_to :blocked_user, class_name: :User

  scope :blocked_users, ->(user_id) {where(user_id: user_id)}
end
