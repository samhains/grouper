class Message < ActiveRecord::Base
  paginates_per 7
  belongs_to :author, foreign_key: :user_id, class_name: :User
  has_many :message_users
  has_many :users, through: :message_users
  validates_presence_of :body, :author, :subject

  auto_html_for :body do
    html_escape
    image('max-width'=> '400px')
    youtube(:width => 400, :height => 250)
    soundcloud
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def receiver 
    MessageUser.where(message: self, placeholder: "Inbox").first.user
  end
end
