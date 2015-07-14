require 'rails_helper'

describe UsersController do
  describe "GET #portal" do
    let (:group) { Fabricate(:group) }
    let (:group2) { Fabricate(:group) }
    let (:user) { Fabricate(:user) }

    before do
      set_current_user user
      user.groups << [group, group2]
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :portal }
    end

    it "sets @groups to all users groups" do
      get :portal
      expect(assigns(:groups)).to include(group, group2)
    end

    it "sets @posts to most recent posts" do
      new_post = Fabricate(:post)
      new_post2 = Fabricate(:post)
      group2.posts << new_post2
      group.posts << new_post
      expect(assigns(:posts)).to eq([new_post, new_post2])
    end

  end

  describe "GET #new" do
    it "redirects to the portal page if user already logged in" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end

    it "creates a new @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST #create" do
    context "valid user input" do
      before do
        post :create, user:  Fabricate.attributes_for(:user) 
      end

      it "creates a new @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "sets the session to current user id" do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it "sets the flash to success message" do
        expect(flash[:success]).to_not be_nil
      end
      
      it "creates a user in the db" do
        expect(User.count).to eq(1)
      end

      it "redirects to root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "user invalid input" do
      before { post :create, :user => { name: "Sam" } } 

      it "render sign up form" do
         expect(response).to render_template('users/new')
      end
      
      it "does not create user" do
        expect(User.count).to eq(0)
      end
    end 

  end
end
