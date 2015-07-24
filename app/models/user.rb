class User < ActiveRecord::Base
  has_secure_password
  has_many :message_users
  has_many :messages, through: :message_users
  has_many :discussion_users
  has_many :discussions, through: :discussion_users
  has_many :posts, ->{ order('created_at DESC') }
  has_many :comments
  has_many :likes
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :notifications, ->{ order('created_at DESC') }  
  validates_presence_of :name, :username
  validates_uniqueness_of :username

  def self.search_by_name(query)
    return [] if query.blank?
    where("LOWER(name) LIKE ? OR LOWER(username) LIKE ?",
          "%#{query.downcase}%",
          "%#{query.downcase}%").order('created_at DESC').limit(5)
  end

  def get_followed_discussions
    Discussion.where(id: discussions).order('last_updated DESC')
  end

  def get_like(likeable)
    Like.find_by(likeable_id: likeable.id, likeable_type: likeable.class.name, user: self)
  end

  def likes?(likeable)
    !!self.get_like(likeable)
  end

  def is_friend?(friend)
    return unless friend
    self.friendships.map(&:friend).include?(friend)
  end

  def get_my_discussions
    Discussion.where(creator: self).order('last_updated DESC')
  end

  def friendship(current_user)
    Friendship.where(user: current_user, friend_id: self).first
  end

  def unread_email_count
    MessageUser.where(is_read: false, user: self, placeholder: "Inbox").count
  end

  def belongs_to_discussion?(discussion_id)
    self.discussions.include?(Discussion.find(discussion_id))
  end

  def created_post?(post_id)
    Post.find(post_id).user == self
  end

  def is_read?(message, placeholder)
    message = MessageUser.where(
      user: self, 
      placeholder: placeholder, 
      message: message).first
    message.is_read? if message
  end

  def created_comment?(comment_id)
   Comment.find(comment_id).user == self  
  end

  def get_messages(placeholder)
    message_users.where(placeholder: placeholder).order('created_at DESC')
  end

  def mark_as_read(message)
    message_user =  message.message_users.where(
      is_read: false, 
      user_id: self).first

    if message_user &&  !message_user.is_read 
      message_user.is_read = true
      message_user.save
    end
  end

  def recent_discussions
    recent_discussions_count = 6 - discussions.count
    if recent_discussions_count > 0
      return Discussion.where('last_updated IS NOT NULL')
      .order('last_updated DESC').limit(recent_discussions_count)
    end
  end


end
