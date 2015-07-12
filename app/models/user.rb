class User < ActiveRecord::Base
  has_secure_password
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :posts
  has_many :comments
  validates_presence_of :name, :username
  validates_uniqueness_of :username

  def belongs_to_group?(group_id)
    self.groups.include?(Group.find(group_id))
  end

end
