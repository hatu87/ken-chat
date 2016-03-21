class AddReadAtToMessageRecipient < ActiveRecord::Migration
  def change
    add_column :message_recipients, :read_at, :datetime
  end
end
