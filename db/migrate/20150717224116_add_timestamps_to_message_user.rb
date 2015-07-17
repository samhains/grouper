class AddTimestampsToMessageUser < ActiveRecord::Migration
  def change
    add_timestamps(:message_users)
  end
end
