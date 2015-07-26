class Discussion < ActiveRecord::Base
  paginates_per 8
  has_many :discussion_users
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :last_author, class_name: 'User', foreign_key: 'last_author_id'
  has_many :users, through: :discussion_users
  has_many :posts,  ->{ order('created_at DESC') }
  validates_length_of :description, :maximum => 150
  validates_presence_of :name, :description

  def followers
  end

  def last_post_author
    if last_author 
      return last_author
    elsif !posts.empty?
      posts.first.user
    end
  end

end

