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

  # callback handler for login with facebook
  # 1. user is existed with a linked facebook account
  # 2. user is existed but not facebook account
  # 3. user is not existed, return nil
  def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    binding.pry
    # find users by uid

    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    account = Account.find_by_uid(auth[:uid])

    if account.nil?
      # do not have facebook acccount
      # check if user is existed by email
      existed_user = User.find_by_email(email)

      existed_user && existed_user.accounts.create(uid: auth[:uid], provider: auth[:provider]).user
      # if existed_user.nil?
      #   # cannot find old email. Your account is not existed
      #   # create new user & account
      #   existed_user = User.create(name: auth[:info][:name], email: email,
      #     password: '123', password_confirmation: '123')
      # end

      # existed_user.accounts.create(uid: auth[:uid], provider: auth[:provider])

      # existed_user
    else
      # facebook account is existed
      account.user
    end

    # user = account && (account.user || )
    # user = where(email: email).first_or_initialize
    # user.accounts.build(uid: auth[:uid], provider: auth[:provider])
    # #
    # # Set other properties on user here.
    # # You may want to call user.save! to figure out why user can't save
    # #
    # # Finally, return user
    # user.save && user
  end
end
