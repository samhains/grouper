class CreateInboxTables < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :subject
      t.text :body
      t.integer :user_id
      t.timestamps
    end

    add_index :messages, :user_id

    create_table :message_placeholders do |t|
      t.string :placeholder
    end

    create_table :message_users do |t|
      t.integer :message_id
      t.integer :user_id
      t.integer :placeholder_id
      t.boolean :is_read
    end

    add_index :message_users, :user_id
    add_index :message_users, :message_id
    add_index :message_users, :placeholder_id
  end
end
