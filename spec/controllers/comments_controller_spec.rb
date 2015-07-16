require 'rails_helper'

describe CommentsController do
  describe "POST #create" do
    let (:user) { Fabricate(:user) }
    let (:discussion) { Fabricate(:discussion, users: [user]) }
    let (:new_post) { Fabricate(:post, user: user, discussion: discussion) }

    it_behaves_like "requires sign in" do
      let (:action) do
        post :create, post_id: new_post.id, discussion_id: discussion.id, comment: Fabricate.attributes_for(:comment)
      end
    end

    context "valid input" do
      before do
        set_current_user user
        @request.env['HTTP_REFERER'] = root_path
        post :create, post_id: new_post.id, discussion_id: discussion.id, comment: Fabricate.attributes_for(:comment)
      end

      it "creates @comment" do
        expect(assigns[:comment]).to be_instance_of(Comment)
      end

      it "saves @comment to database" do
        expect(Comment.count).to eq(1)
      end

      it "associates @comment with current user" do
        expect(Comment.first.user).to eq(user)
      end

      it "associates @comment with current post" do
        expect(Comment.first.post).to eq(new_post)
      end

      it "redirects to discussion_path" do
        expect(response).to redirect_to root_path
      end
      
    end

    context "invalid input" do
      before do
        set_current_user user
        post :create, post_id: new_post.id, discussion_id: discussion.id, comment: { body: nil } 
      end

      it "does not save to database" do
        expect(Comment.count).to eq(0)
      end

      it "sets the flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders the discussion page" do
        expect(response).to render_template 'discussions/show'
      end

    end
  end
  describe "DELETE #destroy" do
    let(:new_comment) { Fabricate(:comment) }
    let(:new_post) { Fabricate(:post) }
    let(:user) { Fabricate(:user) }
    let(:discussion) { Fabricate(:discussion) }

    before do 
      set_current_user user
      @request.env['HTTP_REFERER'] = discussion_path(discussion)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, discussion_id: discussion.id, id: new_comment.id, post_id: new_post }
    end

    it "sets successful flash message" do
      delete :destroy, discussion_id: discussion.id, post_id: new_post, id: new_comment.id 
      expect(flash[:success]).to_not be_nil
    end

    it "redirects to discussion path" do
      delete :destroy, discussion_id: discussion.id, post_id: new_post, id: new_comment.id
      expect(response).to redirect_to discussion_path(discussion)
    end

    it "does not delete if user did not create comment" do
      delete :destroy, discussion_id: discussion.id, post_id: new_post, id: new_comment.id
    end

    it "deletes comment from database if user created it" do
      user.comments << new_comment
      user.save
      delete :destroy, discussion_id: discussion.id, post_id: new_post, id: new_comment.id
      expect(Comment.count).to eq(0)
    end
  end
end
