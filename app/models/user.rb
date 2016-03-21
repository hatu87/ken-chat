class User < ActiveRecord::Base
  attr_accessor :password_confirmation

  has_secure_password

  # enum
  enum status: [:registered, :unregistered]

  # associations
  has_many :accounts
  has_many :sent_messages, foreign_key: :sender_id, class_name: :Message
  # has_and_belongs_to_many :received_messages, class_name: :Message,
  #   join_table: :message_recipients,
  #   foreign_key: :recipient_id

  has_many :message_recipients, foreign_key: :recipient_id
  has_many :received_messages, class_name: :Message,
    through: :message_recipients, source: :message

  # list of friends
  # has_many :friends, class_name: :User, through: :friends, foreign_key: 'friend_id'
  has_and_belongs_to_many :friends, class_name: :User,
    join_table: :friends,
    foreign_key: :friend_id

  # has_many :be_friends, class_name: :User, through: :friends

  # list of users who block this user
  has_and_belongs_to_many :blocking_users, class_name: :User,
    join_table: :blocks, foreign_key: :id

  # list of users who are blocked by this user
  has_and_belongs_to_many :blocked_users, class_name: :User,
    join_table: :blocks, association_foreign_key: :blocked_user_id


  # validations
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  # scope
  scope :except_current, -> (id) { where("id != ?", id) }

  # custom functions

  def friend?(friend)
    # binding.pry
    !friends.find_by_id(friend.id).nil?
  end
end
