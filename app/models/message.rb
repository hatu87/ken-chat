class Message < ActiveRecord::Base
  attr_accessor :emails_string

  has_many :attachments, dependent: :destroy
  belongs_to :sender, class_name: :User

  # has_and_belongs_to_many :recipients, class_name: :User,
  #   association_foreign_key: :recipient_id, join_table: :message_recipients
  has_many :message_recipients
  has_many :recipients, through: :message_recipients

  validates :sender, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }


  # callbacks
  before_create :set_emails

  def unread?(recipient_id)
    message_recipient = message_recipients.find_by_recipient_id(recipient_id)
    !message_recipient.nil? && message_recipient.read_at.nil?
  end

  def unread?
    message_recipients.where.not(read_at: nil).count == 0
  end

  def mark_as_read(recipient_id)
   message_recipient = message_recipients.find_by_recipient_id(recipient_id)
   message_recipient.update(read_at: Time.now)
  end

  def read_at
    message_recipients.select(:read_at).order(read_at: :desc).first
  end

  def set_emails
    # binding.pry

    unless emails_string.nil?
      emails_string.split(',').each do |item|
        binding.pry
        recipient = User.find_by_email(item)

        unless recipient.nil?
          # user is existed
          binding.pry
          recipients << recipient
        else
          # Rails.logger.warning "#{item} is not existed"
          # user is not existed
          # check if email is valid
          # if valid create an unregisterd user
          binding.pry
          recipient = User.new(email: item)
          recipient.save(validate: false)
          recipients << recipient
        end
      end
    end
  end
end
