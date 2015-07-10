class User < ActiveRecord::Base
  has_secure_password
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :posts
  has_many :comments
  validates_presence_of :name, :username
  validates_uniqueness_of :username

end
