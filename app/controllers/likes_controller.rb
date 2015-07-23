class LikesController < ApplicationController 
  before_action :require_user

  def index
    if params[:type] == 'Post' 
      @post = Post.find(params[:id])
      render json: { likers: @post.likers }
    elsif params[:type] == 'Comment'
    end
  end

  def create
    get_likeable(params[:id], params[:type])
    @like = Like.new(user_id: current_user.id)
    @like.likeable = @likeable
    if @like.save
      render json: {like: @like}
    end
  end

  def destroy
    @like = Like.where(likeable_type: params[:type], likeable_id: params[:id], user: current_user).first
    if @like
      @like.destroy
    end
    render json: {like: @like}
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

