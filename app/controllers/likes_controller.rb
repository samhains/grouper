class LikesController < ApplicationController 
  before_action :require_user

  def create
    get_likeable(params[:id], params[:type])
    @like = Like.new(user_id: current_user.id)
    @like.likeable = @likeable
    @notification = Notification.create(user: @likeable.user, notifiable:@likeable)
    if @like.save
      render json: {likers: @like.likeable.likers}
    end
  end

  def destroy
    @like = Like.where(
      likeable_type: params[:type], 
      likeable_id: params[:id], 
      user: current_user).first
    if @like
      @like.destroy
    end
    render json: {likers: @like.likeable.reload.likers}
  end

  private

  def get_likeable(id, type)
    if type == 'Post'
      @likeable = Post.find(id)
    elsif type == 'Comment'
      @likeable = Comment.find(id)
    end
  end
end

