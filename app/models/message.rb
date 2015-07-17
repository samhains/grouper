class Message < ActiveRecord::Base
  belongs_to :author, foreign_key: :user_id, class_name: :User
  has_many :message_users
  has_many :users, through: :message_users
  validates_presence_of :body, :author

  def get_receiver 
    MessageUser.where(message: self, placeholder: "Inbox").first.user
  end
end
