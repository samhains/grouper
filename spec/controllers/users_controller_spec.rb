require 'rails_helper'

describe UsersController do
  describe "GET #new" do
    it "creates a new @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST #create" do
    it "creates a new @user" do
      post :create
      expect(assigns(:user)).to be_instance_of(User)
    end

  end
end
