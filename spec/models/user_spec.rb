require 'rails_helper'

describe User do
  it { should have_many(:groups).through(:group_users) } 
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  let(:user) { Fabricate(:user) }
  let(:new_post) { Fabricate(:post) }
  let(:group) { Fabricate(:group) }
  let(:group2) { Fabricate(:group) }

  describe "#belongs_to_group?" do
    it "returns true if user belongs to group" do
      user.groups << group
      expect(User.first.belongs_to_group?(group.id)).to eq(true)
    end

    it "returns false if user doesn't belong to group" do
      user.save
      expect(User.first.belongs_to_group?(group.id)).to eq(false)
    end
  end


  describe "#created_post?" do
    it "returns true if the user created the post" do
      user.posts << new_post
      user.save
      expect(User.first.created_post?(new_post.id)).to eq(true)
    end

    it "returns false if the user did not create the new_post" do
      user.save
      expect(User.first.created_post?(new_post.id)).to eq(false)
    end
  end

  describe "#recent_posts" do
    before do
      user.groups << [group, group2]
    end
    it "gets all of the posts from groups user is involved with" do
      new_post2 = Fabricate(:post)
      group2.posts << new_post2
      group.posts << new_post
      expect(user.reload.recent_posts).to include(new_post, new_post2)
    end

    it "limits the posts to 10" do
      12.times do
        new_post = Fabricate(:post, user: user)
        group.posts << new_post
      end
      expect(user.recent_posts.count).to eq(10)
    end
  end
end

