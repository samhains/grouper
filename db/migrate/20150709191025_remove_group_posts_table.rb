class RemoveGroupPostsTable < ActiveRecord::Migration
  def change
    drop_table :group_posts
    add_column :posts, :group_id, :integer
    add_index :posts, :group_id
  end
end
