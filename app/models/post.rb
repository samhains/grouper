class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  has_many :comments
  validates_presence_of :user, :discussion

end
