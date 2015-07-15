class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :discussion
  has_many :comments
  validates_presence_of :user, :title, :discussion

  def clean_time
    created_at.strftime ("%b %e, %l:%M %p") 
  end
end
