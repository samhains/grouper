require 'rails_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:creator) }
  it { should belong_to(:notifiable) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:notifiable) }

  describe "#body" do
    xit "retrieves the likeable body" do
      notification = Fabricate(:notification)
      expect(notification.body).to eq(notification.notifiable.likeable.body)
    end
     it "should abbreviate long text with ..." do
     end
  end
end
