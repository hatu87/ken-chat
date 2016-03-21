class RemoveUsernameFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :username, :string
  end
end
