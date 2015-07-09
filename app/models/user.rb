class User < ActiveRecord::Base
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :posts
  has_many :comments

end
