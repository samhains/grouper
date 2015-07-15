class ChangeThreadToDiscussion < ActiveRecord::Migration
  def change
    rename_table :thread_users, :discussion_users
    rename_table :threads, :discussions
    rename_column :posts, :thread_id, :discussion_id
    rename_column :discussion_users, :thread_id, :discussion_id
  end
end
