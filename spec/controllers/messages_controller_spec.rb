require 'rails_helper'

describe MessagesController do
  let(:user) { Fabricate(:user) }

  describe "GET #index" do
    it "sets @messages to all users messages" do
    end
  end

  describe "POST #create" do
    before do
      set_current_user user
    end

    it_behaves_like "requires sign in" do
      let (:action) { post :create, message: Fabricate.attributes_for(:message)}
    end

    it "sets @message" do
    end

    it "associates author with logged in user" do
    end

    it "sets @message_user" do
    end

    it "redirects to inbox" do
      post :create, message: Fabricate.attributes_for(:message)
      expect(response).to redirect_to inbox_path
    end

  end

  describe "GET #new" do

  end

end
