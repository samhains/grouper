class AddDescriptionToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :description, :text
    add_column :groups, :user_id, :integer
    add_index :groups, :user_id
  end
end
