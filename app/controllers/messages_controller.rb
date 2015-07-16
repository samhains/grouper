class MessagesController < ApplicationController
  before_action :require_user

  def index
    @inbox_messages = current_user.message_users.where(placeholder: "Inbox").map(&:message)
    #get all inbox messages for current user
    #current_user.message_users.where(placeholder: "Sent").map(&:message)
  end
  
  def show
    @message = Message.find(params[:id])
    @receiver = MessageUser.where(message: @message, placeholder: "Inbox").first.user
  end

  def create
    @message = Message.new(message_params.merge!(author: current_user))
    receiver = User.find(params[:receiver_id]) if has_receiver? params
    if receiver && @message.save 
      @receiver_message_user = MessageUser.create(message: @message, user_id: receiver.id, placeholder: "Inbox", is_read: false)
      @sender_message_user = MessageUser.create(message: @message, user_id: current_user.id, placeholder: "Sent", is_read: true)
      flash[:success] = "Your message has been sent!"
      redirect_to inbox_path
    else
      flash[:danger] = "There was a problem with your message!"
      render 'messages/new'
    end
  end

  def new
    @message = Message.new
  end

  private

  def has_receiver?(params)
    params.has_key?(:receiver_id) && !params[:receiver_id].empty?
  end
  def message_params
    params.require(:message).permit(:subject, :body, :user)
  end
end
