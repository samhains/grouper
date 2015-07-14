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

  describe "#belongs_to_group?" do
    it "returns true if user belongs to group" do
      user.groups << group
      user.save
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
    it "gets all of the posts from groups user is involved with"
    it "limits the posts to 10"
  end
end

