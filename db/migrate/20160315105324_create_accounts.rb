class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :provider
      t.string :username

      t.timestamps null: false
    end
  end
end
