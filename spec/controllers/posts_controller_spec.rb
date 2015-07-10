require 'rails_helper'

describe PostsController do
  describe "GET #index" do
    it "sets @posts to posts of the post" do
    end
  end

  describe 'POST #create' do

    before { set_current_user }

    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @post instance variable" do
      post :create, post: Fabricate.attributes_for(:post)
      expect(assigns(:post)).to be_instance_of(Group)
    end

    context "valid input " do
      before { post :create, post: Fabricate.attributes_for(:post) }

      it "saves post to database" do
        expect(Group.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects user to the post page" do
        expect(response).to redirect_to group_path(Group.first)
      end
    end

    context "invalid input " do
      before { post :create, post: { description: 'hey' } }

      it "does not save post to database" do
        expect(Group.count).to eq(0) 
      end

      it "sets flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders post/new form" do
        expect(response).to render_template 'groups/new'
      end
    end
  end
end
