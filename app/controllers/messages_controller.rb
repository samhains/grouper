class MessagesController < ApplicationController
  before_action :require_user

  def index
  end

  def create
    binding.pry
    @message = Message.new(message_params)
    if @message.save

      @receiver_message_user = MessageUser.create(message: @message, user_id: params[:receiver_id], placeholder: "Inbox", is_read: false)
      @sender_message_user = MessageUser.create(message: @message, user_id: current_user, placeholder: "Sent", is_read: true)
    redirect_to inbox_path
    else
    end
  end

  def new
    @message = Message.new
  end

  private
  def message_params
    params.require(:message).permit(:subject, :body, :user)
  end
end
