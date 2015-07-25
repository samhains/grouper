class LastUpdateAuthorToCommentsPosts < ActiveRecord::Migration
  def change
    add_column :discussions, :last_author_id, :integer
  end
end
