require 'rails_helper'

describe NotificationsController do
  let(:user) { Fabricate(:user) }

  describe "GET #index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "sets @notifications to all the users notifications" do
      set_current_user user
      notification = Fabricate(:notification, created_at: 1.day.ago, user: user)
      notification2 = Fabricate(:notification, created_at: 2.days.ago, user: user)
      notification3 = Fabricate(:notification)

      get :index
      expect(assigns[:notifications]).to eq([notification, notification2])
    end

  end
end
