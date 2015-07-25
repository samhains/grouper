require 'rails_helper'

describe PostsController do

  let(:discussion) { Fabricate(:discussion) }
  let(:user) { Fabricate(:user) }
  let(:post1) { Fabricate(:post) }

  describe "GET #show" do

    it "sets @post" do
      get :show, id: post1.id
      expect(assigns[:post]).to be_instance_of(Post)
    end
  end

  describe 'POST #create' do

    before do
      set_current_user user 
      @request.env['HTTP_REFERER'] = thread_path(discussion)
    end
    it_behaves_like "requires sign in" do
      let(:action) { post :create, discussion_id: discussion.id }
    end

    it "sets @post instance variable" do
      post :create, discussion_id: discussion.id, post: Fabricate.attributes_for(:post, user: nil)
      expect(assigns(:post)).to be_instance_of(Post)
    end

    it "does not save to database if user is not a member of discussion" do
      post :create, discussion_id: discussion.id, post: Fabricate.attributes_for(:post)
      expect(Post.count).to eq(0)
    end

    context "valid input " do
      before do
        user.discussions <<  discussion
        post :create, discussion_id: discussion.id, post: Fabricate.attributes_for(:post, user: nil) 
      end

      it "saves post to database" do
        expect(Post.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects user to the discussion page" do
        expect(response).to redirect_to thread_path(Discussion.first)
      end

      it "associates @post with current user" do
        expect(Post.first.user.id).to be(user.id)
      end

      it "associates @post with discussion" do
        expect(Post.first.discussion.id).to be(discussion.id)
      end

      it "sets last_author of discussion to current_user" do
        expect(Discussion.first.last_author).to eq(user)
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

      it "associates @notifications user with thread owner" do
        expect(Notification.first.user).to eq(Post.first.discussion.creator)
      end

      it "associates @notification with post" do
        expect(Notification.first.notifiable).to eq(Post.first)
      end

    end

    it "does not create a notification if user posts in their own thread" do
        set_current_user user
        discussion2 = Fabricate(:discussion, creator: user)
        post :create, discussion_id: discussion2.id, post: Fabricate.attributes_for(:post, user: user) 
        expect(Notification.count).to eq(0)
    end

    context "invalid input " do
      before do
        post :create, discussion_id: discussion.id, post: { body: 'hey' } 
        @request.env['HTTP_REFERER'] = thread_path(discussion)
      end

      it "does not save post to database" do
        expect(Post.count).to eq(0) 
      end

      it "sets flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders discussions/show form" do
        expect(response).to render_template 'discussions/show'
      end
    end
  end

  describe "DELETE #destroy" do
    let(:new_post) { Fabricate(:post, discussion: discussion) }

    before do 
      set_current_user user
      @request.env['HTTP_REFERER'] = thread_path(discussion)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, discussion_id: discussion.id, id: new_post.id }
    end


    it "sets successful flash message" do
      delete :destroy, discussion_id: discussion.id, id: new_post.id 
      expect(flash[:success]).to_not be_nil
    end

    it "redirects to discussion path" do
      delete :destroy, discussion_id: discussion.id, id: new_post.id
      expect(response).to redirect_to thread_path(discussion)
    end

    it "does not delete if user did not create post" do
      delete :destroy, discussion_id: discussion.id, id: new_post.id
    end

    it "deletes post from database if user created it" do
      user.posts << new_post
      user.save
      delete :destroy, discussion_id: discussion.id, id: new_post.id
      expect(Post.count).to eq(0)
    end
  end
end
