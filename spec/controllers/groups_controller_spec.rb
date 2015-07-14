require 'rails_helper'

describe GroupsController do

  let(:user) { Fabricate(:user) }
  let(:group) { Fabricate(:group) }
  before { set_current_user user}

  describe 'GET #index' do
    it "sets @groups variable " do
      group2 = Fabricate(:group)
      get :index
      expect(assigns(:groups)).to include(group, group2)
    end
  end

  describe 'GET #new' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @group instance variable" do
      get :new
      expect(assigns(:group)).to be_instance_of(Group)
    end
  end

  describe 'PUT #join' do
    
    it_behaves_like "requires sign in" do
      let(:action) { put :join, group_id: group.id }
    end

    it "associates a user with a group" do
      put :join, group_id: group.id 
      expect(group.reload.users).to include(user)
    end

    it "redirects user to the group path" do
      put :join, group_id: group.id 
      expect(response).to redirect_to(group_path(group))
    end
  end

  describe 'POST #create' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    it "sets @group instance variable" do
      post :create, group: Fabricate.attributes_for(:group)
      expect(assigns(:group)).to be_instance_of(Group)
    end

    context "valid input " do
      before { post :create, group: Fabricate.attributes_for(:group) }

      it "saves group to database" do
        expect(Group.count).to eq(1)
      end

      it "sets flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects user to the group page" do
        expect(response).to redirect_to group_path(Group.first)
      end
    end

    context "invalid input " do
      before { post :create, group: { description: 'hey' } }

      it "does not save group to database" do
        expect(Group.count).to eq(0) 
      end

      it "sets flash message" do
        expect(flash[:danger]).to_not be_nil
      end

      it "renders group/new form" do
        expect(response).to render_template 'groups/new'
      end
    end
  end

  describe "GET #show" do

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: group.id  }
    end

    it "sets @posts to posts of the group" do
      post1 = Fabricate(:post, group: group)
      post2 = Fabricate(:post, group: group)

      get :show, id: group.id
      expect(assigns(:posts)).to include(post1, post2)
    end

    it "sets @posts in reverse chronological order" do
      post1 = Fabricate(:post, group: group, created_at: 2.weeks.ago)
      post2 = Fabricate(:post, group: group, created_at: 1.weeks.ago)
      post3 = Fabricate(:post, group: group, created_at: 3.weeks.ago)
      get :show, id: group.id
      expect(assigns(:posts)).to eq([post2, post1, post3])
    end

    it "sets @post" do
      get :show, id: group.id
      expect(assigns(:post)).to be_instance_of(Post)
    end
  end

  describe "delete #leave" do
    before do 
      user.groups << group
      user.save
      delete :leave, group_id: group.id 
    end

    it "removes the current users association with group" do
      expect(user.reload.groups).to_not include(group)
    end

    it "redirects user to the root path" do
      expect(response).to redirect_to root_path
    end
  end

end
