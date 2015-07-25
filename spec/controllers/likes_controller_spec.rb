require 'rails_helper'

describe LikesController do
    let(:post1) { Fabricate(:post) }
    let(:comment1) { Fabricate(:comment) }
    let(:user) { Fabricate(:user) }

  describe "POST #create" do
    context "user likes a post" do

      before do
        set_current_user user
        post :create, id: post1.id, type: 'Post'
      end

      it_behaves_like "requires sign in" do
        let(:action) { post :create, id: post1.id, type: 'Post'}
      end

      it "sets @like" do
        expect(assigns(:like)).to be_instance_of Like
      end

      it "associates @like with current user" do
        expect(Like.first.user).to eq(user)
      end

      it "creates a @notification" do
        expect(assigns[:notification]).to be_instance_of Notification
      end

      it "saves @notification to db" do
        expect(Notification.count).to eq(1)
      end

      it "associates @notification creator with current user" do
        expect(Notification.first.creator).to eq(user)
      end

      it "associates @notifications user with likeable user" do
        expect(Notification.first.user).to eq(post1.user)
      end

      it "associates @notification with like" do
        expect(Notification.first.notifiable).to eq(Like.first)
      end
      it "sets likeable_id to post id" do
        expect(Like.first.likeable_id).to eq(post1.id)
      end
      it "creates saves like to db" do
        expect(Like.count).to eq(1)
      end

      it "sets likeable to post object if likeable is post" do
        expect(assigns[:likeable]).to be_instance_of Post
      end

      it "renders json @like in response" do
        expect(response.body).to eq({ "likers"=> Like.first.likeable.likers}.to_json)
      end

    end
    
    it "does not create a notification if user likes their own content" do
        set_current_user user
        post2 = Fabricate(:post, user: user)
        post :create, id: post2.id, type: 'Post'
        expect(Notification.count).to eq(0)
    end

    xit "sets likeable to comment object if likeable is comment" do
      set_current_user user
      post :create, id: comment1.id, type: 'Comment'
      expect(assigns[:likeable]).to be_instance_of Comment
    end

    xit "associates @notification with comment author" do
    end

  end

  describe "DELETE #destroy" do
    let!(:like) { Like.create(likeable_id: post1.id, likeable_type: 'Post', user: user) }
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: post1.id, type: 'Post' }
    end

    it "deletes like from database" do
      set_current_user user
      expect(Like.count).to eq(1)
      delete :destroy, id: post1.id, type: 'Post'
      expect(Like.count).to eq(0)
    end
  end
end
