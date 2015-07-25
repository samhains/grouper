class Like < ActiveRecord::Base
  belongs_to :user
  has_many :notifications, as: :notifiable
  belongs_to :likeable, polymorphic: true

end

