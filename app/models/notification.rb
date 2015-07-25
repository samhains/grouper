class Notification < ActiveRecord::Base
  paginates_per 6
  belongs_to :user
  belongs_to :notifiable, polymorphic: true 
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates_presence_of :user, :notifiable

  def liked_class
    notifiable.likeable.class
  end

  def type
    notifiable.class
  end


  def text
    notifiable.body_html
  end

  def discussion
    notifiable.discussion if type == Post
  end

  def post
    if type == Like
      if notifiable.likeable.class == Post
        notifiable.likeable
      elsif notifiable.likeable.class == Comment
        notifiable.likeable.post
      end
    elsif type == Comment
      notifiable.post
    end
  end

  def post_title?
    if type == Like
      if notifiable.likeable.class == Post
        notifiable.likeable.title.empty?
      elsif notifiable.likeable.class == Comment
        notifiable.likeable.post.title.empty?
      end
    elsif type == Comment
      notifiable.post.title.empty?
    end
  end

  def liked_content
    notifiable.likeable.body_html if type == Like
  end
end
