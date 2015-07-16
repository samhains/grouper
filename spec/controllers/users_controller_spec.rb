require 'rails_helper'

describe UsersController do
  let (:discussion) { Fabricate(:discussion, last_updated: 1.hour.ago) }
  let (:discussion2) { Fabricate(:discussion, last_updated: 2.hour.ago) }
  let (:user) { Fabricate(:user) }

  describe "GET #show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: user.id }
    end

    before { set_current_user user }
    
    it "sets @posts" do
      new_post = Fabricate(:post, user: user)
      new_post2 = Fabricate(:post, user: user)
      get :show, id: user.id
      expect(assigns[:posts]).to include(new_post, new_post2)
    end
  end

  describe "GET #portal" do
    before do
      set_current_user user
      user.discussions << [discussion, discussion2]
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :portal }
    end

    it "sets @discussions to all users discussions" do
      get :portal
      expect(assigns(:discussions)).to include(discussion, discussion2)
    end

    it "sets @posts to most recent posts" do
      new_post = Fabricate(:post, created_at: 1.week.ago)
      new_post2 = Fabricate(:post, created_at: 2.weeks.ago)
      discussion2.posts << new_post2
      discussion.posts << new_post
      get :portal
      expect(assigns(:posts)).to eq([new_post, new_post2])
    end

    it "sets @comment" do
      get :portal
      expect(assigns(:comment)).to be_instance_of(Comment)
    end

    it "sets @recent_discussions" do
      get :portal
      expect(assigns(:recent_discussions)).to eq([discussion, discussion2])
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
