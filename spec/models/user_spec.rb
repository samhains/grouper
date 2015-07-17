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

  describe ".search_by_name" do
    it "returns array of users that contain query in their name" do
      sam = Fabricate(:user, name: "Sam Hains")
      sam2 = Fabricate(:user, name: "Sam Dean")
      expect(User.search_by_name('Sa')).to include(sam, sam2)
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


  describe "#recent_discussions" do
  end

  describe "#discussion_feed" do
  end

  describe "#recent_posts" do
    before do
      user.discussions << [discussion, discussion2]
    end

    it "gets all of the posts from discussions user is involved with" do
      user2 = Fabricate(:user)
      new_post2 = Fabricate(:post, user: user2)
      discussion2.posts << new_post2
      discussion.posts << new_post
      expect(user.reload.recent_posts).to include(new_post, new_post2)
    end

    it "limits the posts to 10" do
      12.times do
        new_post = Fabricate(:post, user: user)
        discussion.posts << new_post
      end

      expect(user.recent_posts.count).to eq(10)
    end

    it "returns only the 10 most recent" do
      older_post = Fabricate(:post, created_at: 1.week.ago)
      older_post2 = Fabricate(:post, created_at: 1.week.ago)

      12.times do
        new_post = Fabricate(:post, user: user, created_at: 1.day.ago)
        discussion.posts << new_post
      end

      expect(user.recent_posts).to_not include(older_post, older_post2)
    end

    it "returns them in reverse chronological order" do
      newest_post = Fabricate(:post, created_at: 1.week.ago, user: user)
      newer_post = Fabricate(:post, created_at: 2.week.ago, user: user)
      new_post = Fabricate(:post, created_at: 3.week.ago, user: user)
      discussion.posts << [new_post, newer_post, newest_post]
      expect(user.recent_posts).to eq([newest_post, newer_post, new_post])
    end
  end
end

