require 'rails_helper'

describe FriendshipsController do

  let (:friend) { Fabricate(:user) }
  let (:user) { Fabricate(:user) }

  before do
    set_current_user user
  end

  describe "GET #index" do
    it "sets @friendships to the current users friendships" do
      friendship = Friendship.create(user: user, friend: friend)
      get :index
      expect(assigns[:friendships]).to eq([friendship])
    end
  end

  describe "POST #create" do

    it_behaves_like "requires sign in" do
      let(:action) { post :create, friend_id: friend.id } 
    end
    
    it "sets @friendship" do 
      post :create, friend_id: friend.id 
      expect(assigns[:friendship]).to be_instance_of(Friendship)
    end

    context "valid input" do
      before do
        post :create, friend_id: friend.id 
      end

      it "associates @frienship with current user" do
        expect(Friendship.first.user).to eq(user)
      end

      it "associates @friendship with other user" do
        expect(Friendship.first.friend).to eq(friend)
      end

      it "redirects to user_path" do
        expect(response).to redirect_to user_path(friend)
      end

      it "sets successful flash message" do
        expect(flash[:success]).to_not be_nil
      end
    end

    context "invalid input" do
      before do
        post :create, friend_id: friend.id 
        post :create, friend_id: friend.id 
      end

      it "does not add second friendship  to database" do
        expect(Friendship.count).to eq(1)
      end

      it "renders the user/show page" do
        expect(response).to render_template('users/show')
      end
      
      it "sets unsuccessful flash message" do
        expect(flash[:danger]).to_not be_nil
      end
    end

  end

  describe "DELETE #destroy" do
    
    let! (:friendship) { Friendship.create(user: user, friend: friend) }
    let! (:friendship2) { Fabricate(:friendship) }

    before do
      delete :destroy, id: friendship.id
    end

    it "sets @friendship" do
      expect(assigns[:friendship]).to be_instance_of Friendship
    end

    it "destroys @friendship from db" do
      expect(Friendship.count).to eq(1)
    end

    it "sets flash message" do
      expect(flash[:success]).to_not be_nil
    end

    it "redirects to user_path" do
      expect(response).to redirect_to(user_path(friend))
    end

    it "does not delete friendship if user is not current_user" do
      delete :destroy, id: friendship2.id
      expect(Friendship.count).to eq(1)
    end
  end
end
