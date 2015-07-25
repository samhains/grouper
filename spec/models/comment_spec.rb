require 'rails_helper'

describe Comment do
  it { should belong_to(:post) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:body) }
  it { should have_many(:likes).order('created_at DESC') }

  describe "#likers" do
    it "returns array of all users who like post" do
      user1 = Fabricate(:user)
      user2 = Fabricate(:user)
      comment1 = Fabricate(:comment)
      like1 =  Like.create(likeable_id: comment1.id, likeable_type: 'Comment', user: user1)
      like2 =  Like.create(likeable_id: comment1.id, likeable_type: 'Comment', user: user2) 
      
      expect(comment1.likers).to include(user1, user2)
    end

  end
end
