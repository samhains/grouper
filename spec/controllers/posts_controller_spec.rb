require 'rails_helper'

describe PostsController do

  let(:discussion) { Fabricate(:discussion) }
  let(:user) { Fabricate(:user) }

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
