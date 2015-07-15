class Discussion < ActiveRecord::Base
  has_many :discussion_users
  has_many :users, through: :discussion_users
  has_many :posts,  ->{ order('created_at DESC') }
  validates_presence_of :name

end

