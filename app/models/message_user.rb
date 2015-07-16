class MessageUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :message_placeholder 
  belongs_to :message
end
