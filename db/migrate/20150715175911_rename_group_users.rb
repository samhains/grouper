class RenameGroupUsers < ActiveRecord::Migration
  def change
    rename_table :group_users, :thread_users
  end
end
