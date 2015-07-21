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
      let (:action) { post :create, message: Fabricate.attributes_for(:message, author: user)}
    end

    it "sets @message" do
      post :create, message: Fabricate.attributes_for(:message, author:nil)
      expect(assigns(:message)).to be_instance_of Message
    end

    context "successful validation" do
      let (:receiver) { Fabricate(:user) }

      before do
        post :create, username: receiver.username,  message: Fabricate.attributes_for(:message, author:nil)
      end
      
      it "saves message to database" do
        expect(Message.count).to eq(1)
      end

      it "associates MessageUser object for Inbox with reciever" do
        expect(MessageUser.where(placeholder: "Inbox").first.user_id).to eq(receiver.id)
      end

      it "associates MessageUser object for Sent with sender" do
        expect(MessageUser.where(placeholder: "Sent").first.user_id).to eq(user.id)
      end

      it "saves both message user objects  to db" do
        expect(MessageUser.count).to eq(2)
      end

      it "associates author with logged in user" do
        expect(Message.first.author).to eq(user)
      end

      it "sets successful flash message" do
        expect(flash[:success]).to_not be_nil
      end

      it "redirects to inbox" do
        expect(response).to redirect_to inbox_messages_path
      end
    end

    context "does not validate" do
      before do
        post :create, message: Fabricate.attributes_for(:message)
      end

      it "does not save any message_user entries to db" do
        expect(MessageUser.count).to eq(0)
      end

      it "does not save message to db" do
        expect(Message.count).to eq(0)
      end

      it "renders new message template" do
        expect(response).to render_template('messages/new')
      end

      it "sets danger flash" do
        expect(flash[:danger]).to_not be_nil
      end
    end

  end

  describe "GET #new" do

  end

end
