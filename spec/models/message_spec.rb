require 'rails_helper'

describe Message do
  let(:sender) { Fabricate(:user) }
  let(:receiver) { Fabricate(:user) }
  let(:message) { Fabricate(:message, author: sender) }

  it { should belong_to(:author) }
  it { should have_many(:message_users) }
  it { should have_many(:users).through(:message_users) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author) }

  describe "#receiver" do
    it "should return the user to whom the message is in their inbox" do
      sender_message = MessageUser.create(message: message, placeholder: "Sent", is_read: true, user_id: sender.id)
      receiver_message = MessageUser.create(message: message, placeholder: "Inbox", is_read: false, user_id: receiver.id)
      expect(message.receiver).to eq(receiver)
    end
  end

end
