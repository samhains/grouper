class Post < ActiveRecord::Base
  include AutoHtml
  paginates_per 6
  belongs_to :user
  belongs_to :discussion
  has_many :comments
  has_many :notifications, as: :notifiable
  has_many :likes, ->{ order('created_at DESC') }, as: :likeable
  validates_presence_of :user, :discussion, :body

  auto_html_for :body do
    html_escape
    image
    soundcloud
    youtube(:width => 340, :height => 212)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def likers 
    likes.map(&:user)
  end

end
