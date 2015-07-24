class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true 
  validates_presence_of :user, :notifiable
end
