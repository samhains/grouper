class MessageUser < ActiveRecord::Base
  paginates_per 7
  belongs_to :user
  belongs_to :message
end
