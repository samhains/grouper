class ChangePlaceholderIdName < ActiveRecord::Migration
  def change
    rename_column :message_users, :placeholder_id, :message_placeholder_id
  end
end
