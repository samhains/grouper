class ChangeGroupForeignKeyTables < ActiveRecord::Migration
  def change
    rename_column :posts, :group_id, :thread_id
    rename_column :thread_users, :group_id, :thread_id
  end
end
