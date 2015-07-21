require 'rails_helper'

describe PagesController do
  describe "GET #portal" do
    let(:user) { Fabricate(:user) }
    let(:discussion) { Fabricate(:discussion, last_updated: 1.week.ago) }
    let(:discussion2) { Fabricate(:discussion, last_updated: 2.weeks.ago) }

    before do
      set_current_user user
      user.discussions << [discussion, discussion2]
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
end
