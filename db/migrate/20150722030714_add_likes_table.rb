class AddLikesTable < ActiveRecord::Migration
  def change
    create_table "likes" do |t|
      t.integer "user_id"
      t.string  "likeable_type"
      t.integer "likeable_id"
    end
  end
end
