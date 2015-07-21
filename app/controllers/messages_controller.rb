class MessagesController < ApplicationController
  before_action :require_user
  before_action :get_message, only: [:show]

  def index
    placeholder = params[:placeholder]
    set_messages(placeholder)
  end

  def show
    current_user.mark_as_read(@message)
    @receiver = @message.receiver
  end

  def create
    @message = Message.new(message_params.merge!(author: current_user))
    receiver = get_receiver
    respond_to do |format| 
      if receiver && @message.save 

        create_message_users(@message, receiver)

        flash[:success] = "Your message has been sent!"
        format.html { redirect_to inbox_messages_path } 
        format.json {  render json: @message  }
      else
        flash[:danger] = "There was a problem with your message!"
        format.html { render 'messages/new' }
        format.json { render template: 'messages/new.html.haml', status: 400 }
      end
    end
  end

  def new
    @message = Message.new
  end

  private

  def create_message_users(message, receiver)
    @receiver_message_user = MessageUser.create(
      message: message, 
      user_id: receiver.id, 
      placeholder: "Inbox", 
      is_read: false)
    @sender_message_user = MessageUser.create(
      message: message, 
      user_id: current_user.id, 
      placeholder: "Sent", 
      is_read: true)
  end

  def get_receiver
    User.find_by(username: params[:username]) if has_receiver? params
  end

  def set_messages(placeholder)
    messages = current_user.get_messages(placeholder)
    @messages_paginated = messages.page params[:page]
    @messages = @messages_paginated.map(&:message)
  end

  def get_message 
    @message = Message.find(params[:id])
  end

  def has_receiver?(params)
    params.has_key?(:username) && !params[:username].empty?
  end

  def message_params
    params.require(:message).permit(:subject, :body, :user)
  end
end
