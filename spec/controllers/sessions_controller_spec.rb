require 'rails_helper'

describe SessionsController do
  describe "GET #new" do
    it "redirects to home path if user is logged in" do
      set_current_user
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #create" do
    let(:user) { Fabricate(:user)}

    context "if authentication is successful" do
      before do 
        post :create, username: user.username, password: user.password
      end

      it "creates a session with user_id" do
        expect(session[:user_id]).to eq(user.id)
      end
      
      it "redirects to root_path" do
        expect(response).to redirect_to root_path
      end

    end

    context "if authentication is unsuccessful" do
      before do 
        post :create, username: user.username
      end
      
      it "does not put user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "sets unsuccessful flash notice" do
        expect(flash[:danger]).not_to be_blank
      end

      it "renders the login page" do
        expect(response).to render_template 'sessions/new'
      end
    end
  end

  describe "DELETE #destroy" do
    before {delete :destroy}
    it "sets session to nil" do
      expect(session[:user_id]).to be_nil 
    end

    it "redirects to root_path" do
      expect(response).to redirect_to login_path
    end

  end
end

