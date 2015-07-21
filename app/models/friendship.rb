class Friendship < ActiveRecord::Base
  paginates_per 6
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates_presence_of :friend
  validates_uniqueness_of :friend_id, scope: :user_id
end
