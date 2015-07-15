class RenameGroupsToDiscussions < ActiveRecord::Migration
  def change
    rename_table :groups, :threads
  end
end
