class Discussion < ActiveRecord::Base
  paginates_per 5
  has_many :discussion_users
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :users, through: :discussion_users
  has_many :posts,  ->{ order('created_at DESC') }
  validates_length_of :description, :maximum => 150
  validates_presence_of :name, :description

  def last_post_author
    unless posts.empty?
      posts.first.user
    end
  end

end

