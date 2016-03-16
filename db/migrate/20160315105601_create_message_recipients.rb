class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.integer :recipient_id
      t.integer :message_id

      t.timestamps null: false
    end
  end
end
