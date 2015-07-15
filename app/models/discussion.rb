class Discussion < ActiveRecord::Base
  has_many :discussion_users
  has_many :users, through: :discussion_users
  has_many :posts,  ->{ order('created_at DESC') }
  validates_length_of :description, :maximum => 150
  validates_presence_of :name, :description

  def last_post_author
    unless posts.empty?
      posts.first.user.name
    end
  end

end

