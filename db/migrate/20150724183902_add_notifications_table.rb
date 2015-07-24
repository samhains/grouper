class AddNotificationsTable < ActiveRecord::Migration
  def change
    create_table(:notifications) do |t|
      t.string :notifiable_type
      t.integer :notifiable_id
      t.boolean :user_checked
      t.integer :user_id
      t.timestamps
    end

    add_index :notifications, :user_id
  end
end
