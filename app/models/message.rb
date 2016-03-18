class Message < ActiveRecord::Base
  has_many :attachments, dependent: :destroy
  belongs_to :sender, class_name: :User

  has_and_belongs_to_many :recipients, class_name: :User,
    association_foreign_key: :recipient_id, join_table: :message_recipients

  validates :sender, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :unread, -> { where(read_at: nil) }

  def unread?
    read_at.nil?
  end
end
