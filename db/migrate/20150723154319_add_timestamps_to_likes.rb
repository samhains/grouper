class AddTimestampsToLikes < ActiveRecord::Migration
  def change
    add_timestamps(:likes)
  end
end
