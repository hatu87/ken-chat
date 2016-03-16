class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :url
      t.string :name
      t.integer :message_id

      t.timestamps null: false
    end
  end
end
