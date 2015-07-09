class AddUsersGroupsPostsTables < ActiveRecord::Migration
  def change
    create_table(:users) do |t| 
      t.string :username
      t.string :name
      t.string :password_digest
      t.timestamps
    end

    create_table(:group_users) do |t|
      t.integer :user_id
      t.integer :group_id
    end

    add_index :group_users, :user_id
    add_index :group_users, :group_id

    create_table(:groups) do |t| 
      t.string :name
      t.timestamps
    end

    create_table(:group_posts) do |t| 
      t.integer :group_id
      t.integer :post_id
    end
    
    add_index :group_posts, :group_id
    add_index :group_posts, :post_id

    create_table(:posts) do |t| 
      t.string :title
      t.integer :user_id
      t.timestamps
    end

    add_index :posts, :user_id

    create_table(:comment_posts) do |t|
      t.integer :comment_id
      t.integer :post_id
    end

    add_index :comment_posts, :comment_id
    add_index :comment_posts, :post_id

    create_table(:comments) do |t|
      t.string :body
      t.integer :user_id
      t.timestamps
    end

    add_index :comments, :user_id
  end
end
