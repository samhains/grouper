require 'rails_helper'

describe Post do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should belong_to(:discussion) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:discussion) }
  it { should have_many(:likes).order('created_at DESC') }
  it { should have_many(:notifications) }

  let(:user1) { Fabricate(:user) }
  let(:user2) { Fabricate(:user) }
  let(:user3) { Fabricate(:user) }
  let(:post1) { Fabricate(:post) }

  describe "#likers" do
    it "returns array of all users who like post" do
      like1 =  Like.create(likeable_id: post1.id, likeable_type: 'Post', user: user1) 
      like2 =  Like.create(likeable_id: post1.id, likeable_type: 'Post', user: user2) 
      
      expect(post1.likers).to include(user1, user2)
    end

    it "returns array ordered by like created_at" do
      like1 =  Like.create(likeable_id: post1.id, likeable_type: 'Post', user: user1, created_at: 1.day.ago) 
      like2 =  Like.create(likeable_id: post1.id, likeable_type: 'Post', user: user2, created_at: 1.week.ago) 
      like3 =  Like.create(likeable_id: post1.id, likeable_type: 'Post', user: user3, created_at: 2.days.ago)
      
      expect(post1.likers).to eq([user1, user3, user2])
    end

  end
end
