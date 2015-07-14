require 'rails_helper'

describe PostsController do

  let(:group) { Fabricate(:group) }
  let(:user) { Fabricate(:user) }

  describe 'POST #create' do

    before { set_current_user user }

    it_behaves_like "requires sign in" do
      let(:action) { post :create, id: group.id }
    end

    it "sets @post instance variable" do
      post :create, id: group.id, post: Fabricate.attributes_for(:post, user: nil)
      expect(assigns(:post)).to be_instance_of(Post)
    end

    context "valid input " do
      before do
        post :create, id: group.id, post: Fabricate.attributes_for(:post, user: nil) 
      end

      it "saves post to database" do
        expect(Post.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects user to the group page" do
        expect(response).to redirect_to group_path(Group.first)
      end

      it "associates @post with current user" do
        expect(Post.first.user.id).to be(user.id)
      end

      it "associates @post with group" do
        expect(Post.first.group.id).to be(group.id)
      end
    end

    context "invalid input " do
      before { post :create, id: group.id, post: { body: 'hey' } }

      it "does not save post to database" do
        expect(Post.count).to eq(0) 
      end

      it "sets flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders groups/show form" do
        expect(response).to render_template 'groups/show'
      end
    end
  end

  describe "DELETE #destroy" do
    let(:new_post) { Fabricate(:post, group: group) }

    before do 
      set_current_user user
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: new_post.id }
    end


    it "sets successful flash message" do
      delete :destroy, id: new_post.id 
      expect(flash[:success]).to_not be_nil
    end

    it "redirects to group path" do
      delete :destroy, id: new_post.id
      expect(response).to redirect_to group_path(group)
    end

    it "does not delete if user did not create post" do
      delete :destroy, id: new_post.id
    end

    it "deletes post from database if user created it" do
      user.posts << new_post
      user.save
      delete :destroy, id: new_post.id
      expect(Post.count).to eq(0)
    end
  end
end
