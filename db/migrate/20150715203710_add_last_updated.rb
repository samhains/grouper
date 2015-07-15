class AddLastUpdated < ActiveRecord::Migration
  def change
    add_column :discussions, :last_updated, :timestamp
  end
end
