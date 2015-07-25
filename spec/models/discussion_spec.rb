require 'rails_helper'

describe Discussion do
  it { should have_many(:users).through(:discussion_users) } 
  it { should have_many(:posts) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_most(150) }
  it { should belong_to(:creator) }
  it { should belong_to(:last_author) }

  describe "#followers" do
    it "should return the number of people who have joined group" do
    end
  end

  describe "#last_post_author" do
    it "should retun the user of the last posts author" do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      discussion = Fabricate(:discussion)
      new_post = Fabricate(:post, created_at: 1.week.ago, user: user)
      newer_post = Fabricate(:post, created_at: 1.day.ago, user:user2)
      discussion.posts << [new_post, newer_post]
      expect(discussion.last_post_author).to eq(user2)
    end

    it "should return user of last posts author if last activity is comment" do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      discussion = Fabricate(:discussion)
      new_post = Fabricate(:post, created_at: 1.week.ago, user: user)
      discussion.posts << [new_post]
      new_comment = Fabricate(:comment, created_at: 1.hour.ago, user:user2)
      new_post.comments << new_comment
      discussion.last_author = user2
      discussion.save
      expect(discussion.last_post_author).to eq(user2)

    end
  end

end
