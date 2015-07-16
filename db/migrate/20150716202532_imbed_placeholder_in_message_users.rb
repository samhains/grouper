class ImbedPlaceholderInMessageUsers < ActiveRecord::Migration
  def change
    drop_table :message_placeholders
    remove_column :message_users, :message_placeholder_id
    add_column :message_users, :placeholder, :string
  end
end
