class User < ActiveRecord::Base
  has_secure_password
  has_many :discussion_users
  has_many :discussions, through: :discussion_users
  has_many :posts, ->{ order('created_at DESC') }
  has_many :comments
  validates_presence_of :name, :username
  validates_uniqueness_of :username

  def belongs_to_discussion?(discussion_id)
    self.discussions.include?(Discussion.find(discussion_id))
  end

  def created_post?(post_id)
    Post.find(post_id).user == self
  end

  def recent_posts
    Post.where(discussion_id: self.discussions).order('created_at DESC').limit(10)
  end

end
