require 'rails_helper'

describe DiscussionMembersController do
  let (:user)  { Fabricate(:user) }
  let (:discussion) { Fabricate(:discussion) }

  before do
    set_current_user user
  end

  describe 'POST #create' do
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, thread_id: discussion.id }
    end

    it "associates a user with a discussion" do
      post :create, thread_id: discussion.id 
      expect(discussion.reload.users).to include(user)
    end

    it "redirects user to the discussion path" do
      post :create, thread_id: discussion.id 
      expect(response).to redirect_to(thread_path(discussion))
    end
  end

  describe "DELETE #destroy" do
    before do 
      user.discussions << discussion
      user.save
      delete :destroy, thread_id: discussion.id 
    end

    it "removes the current users association with discussion" do
      expect(user.reload.discussions).to_not include(discussion)
    end

    it "redirects user to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end
