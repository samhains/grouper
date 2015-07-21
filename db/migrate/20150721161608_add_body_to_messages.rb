class AddBodyToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :body_html, :text
  end
end
