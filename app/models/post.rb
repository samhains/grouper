class Post < ActiveRecord::Base
  include AutoHtml
  paginates_per 6
  belongs_to :user
  belongs_to :discussion
  has_many :comments
  validates_presence_of :user, :discussion, :body

  auto_html_for :body do
    html_escape
    image
    soundcloud
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
end
