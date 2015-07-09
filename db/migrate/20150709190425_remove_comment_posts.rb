class RemoveCommentPosts < ActiveRecord::Migration
  def change
    drop_table :comment_posts

    add_column :comments, :post_id, :integer
    add_index :comments, :post_id
  end
end
