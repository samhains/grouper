require 'rails_helper'

describe User do
  it { should have_many(:discussions).through(:discussion_users) } 
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  let(:user) { Fabricate(:user) }
  let(:new_post) { Fabricate(:post) }
  let(:new_comment) { Fabricate(:comment) }
  let(:discussion) { Fabricate(:discussion) }
  let(:discussion2) { Fabricate(:discussion) }
  let(:sender) { Fabricate(:user) }
  let(:receiver) { Fabricate(:user) }
  let(:message) { Fabricate(:message, author: sender) }

  describe ".search_by_name" do
    it "returns array of users that contain query in their name" do
      sam = Fabricate(:user, name: "Sam Hains")
      sam2 = Fabricate(:user, name: "Sam Dean")
      expect(User.search_by_name('Sa')).to include(sam, sam2)
    end

    it "returns array of users that contain query in their username" do
      sam = Fabricate(:user, username: "sdhains")
      sam2 = Fabricate(:user, username: "2_sdhains")
      expect(User.search_by_name('sdhai')).to include(sam, sam2)
    end

    it "is case insensitive" do
      sam = Fabricate(:user, name: "Sam Hains")
      sam2 = Fabricate(:user, name: "Sam Dean")
      expect(User.search_by_name('sa')).to include(sam, sam2)
    end

    it "return users for partially matching query string" do
      sam = Fabricate(:user, name: "Sam Hains")
      sam2 = Fabricate(:user, name: "Sam Dean")
      expect(User.search_by_name('am').count).to eq(2)
    end

    it "does not return users that do not contain query in name" do
      ben = Fabricate(:user, name: "Ben Jones")
      expect(User.search_by_name('sa')).to_not include(ben)
    end
  end

  describe "get_discussions" do
    let(:user) { Fabricate(:user) }
    let(:discussion1) { Fabricate(:discussion, last_updated: 2.days.ago) }
    let(:discussion2) { Fabricate(:discussion, last_updated: 1.day.ago) }
    let(:discussion3) { Fabricate(:discussion) }

    before { user.discussions << [discussion1, discussion2] }
    
    it "gets a list of all of the discussions threads the user belongs to" do
      expect(user.get_discussions).to include(discussion1, discussion2)
    end

    it "does not return discussions that the user is not involved with" do
      expect(user.get_discussions).to_not include(discussion3)
    end

    it "returns the discussions in reverse last_updated order" do
      expect(user.get_discussions).to eq([discussion2, discussion1])
    end
  end

  describe "#is_read?" do
    before do
      sender_message = MessageUser.create(message: message, placeholder: "Sent", is_read: true, user_id: sender.id)
      receiver_message = MessageUser.create(message: message, placeholder: "Inbox", is_read: false, user_id: receiver.id)
    end

    it "returns true if the message has been read" do
      expect(sender.is_read?(message, "Sent")).to eq(true)
    end

    it "returns false if the message has not been read" do
      expect(receiver.is_read?(message, "Inbox")).to eq(false)
    end

  end

  describe "#mark_as_read" do
    it "marks the unread message as read" do
      sender_message = MessageUser.create(message: message, placeholder: "Sent", is_read: true, user_id: sender.id)
      receiver_message = MessageUser.create(message: message, placeholder: "Inbox", is_read: false, user_id: receiver.id)

      expect(receiver.is_read?(message, "Inbox")).to eq(false)
      receiver.mark_as_read(message)
      expect(receiver.is_read?(message, "Inbox")).to eq(true)
    end

  end
  describe "#belongs_to_discussion?" do
    it "returns true if user belongs to discussion" do
      user.discussions << discussion
      expect(User.first.belongs_to_discussion?(discussion.id)).to eq(true)
    end

    it "returns false if user doesn't belong to discussion" do
      user.save
      expect(User.first.belongs_to_discussion?(discussion.id)).to eq(false)
    end
  end

  describe "#created_comment?" do
    it "returns true if the user created the comment" do
      user.comments << new_comment
      user.save
      expect(User.first.created_comment?(new_comment.id)).to eq(true)
    end

    it "returns false if the user did not create the new_comment" do
      user.save
      expect(User.first.created_comment?(new_comment.id)).to eq(false)
    end
  end

  describe "#get_messages" do
   
  end

  describe "#created_post?" do
    it "returns true if the user created the comment" do
      user.posts << new_post
      user.save
      expect(User.first.created_post?(new_post.id)).to eq(true)
    end

    it "returns false if the user did not create the new_post" do
      user.save
      expect(User.first.created_post?(new_post.id)).to eq(false)
    end
  end


end

