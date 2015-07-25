class Notification < ActiveRecord::Base
  paginates_per 6
  belongs_to :user
  belongs_to :notifiable, polymorphic: true 
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates_presence_of :user, :notifiable

  def liked_class
    notifiable.likeable.class
  end
  
  def body
    notifiable.likeable.body 
  end
end
