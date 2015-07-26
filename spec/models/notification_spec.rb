require 'rails_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:creator) }
  it { should belong_to(:notifiable) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:notifiable) }
  let (:notification) { Fabricate(:notification) }
  let (:comment) { Fabricate(:comment) }
  let (:post1) { Fabricate(:post) }
  let (:like) { Fabricate(:like, likeable: post1) }
  let (:like2) { Fabricate(:like, likeable: comment) }
  let (:like_notification) { Fabricate(:notification, notifiable: like) }
  let (:like2_notification) { Fabricate(:notification, notifiable: like2) }
  let (:post_notification) { Fabricate(:notification, notifiable: post1) }
  let (:comment_notification) { Fabricate(:notification, notifiable: comment) }

  describe "#liked_class" do
    it "returns the class of the likeable object" do
      expect(like_notification.liked_class).to eq(like_notification.notifiable.likeable.class)
    end
  end

  describe "#notification_type" do
    it "returns the class of the notification" do
      expect(notification.type).to eq(notification.notifiable.class)
    end
  end

  describe "#notification_text" do
    it "returns the body of text for the post notification" do
      expect(post_notification.text).to eq(post_notification.notifiable.body_html)
    end

    it "returns the body of text for the comment notification" do
      expect(comment_notification.text).to eq(comment_notification.notifiable.body_html)
    end
  end

  describe "#discussion" do
    it " returns the discussion for a post notification" do
      expect(post_notification.discussion).to eq(post_notification.notifiable.discussion)
    end
  end

  describe "#post" do
    it "returns the post object for a like notification on a post" do
      expect(like_notification.post).to eq(post1)
    end

    
    it "returns the post object for a like notification on a comment" do
      expect(like2_notification.post).to eq(comment.post)
    end


    it "returns the post object for a comment notification" do
      expect(comment_notification.post).to eq(comment.post)
    end

  end


  describe "#body" do
    it "returns liked context/text if notification is a like" do
      expect(like_notification.liked_content).to eq(like_notification.notifiable.likeable.body_html)
    end

    it "returns nil if notification is not a like" do
      expect(post_notification.liked_content).to be_nil
    end
  end
end
