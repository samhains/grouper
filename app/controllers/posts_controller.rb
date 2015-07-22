class PostsController < ApplicationController
  before_action :require_user

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @post = Post.new(post_params)
    @post.user = current_user
    @post.discussion = @discussion
    @posts = @discussion.posts
    @comment = Comment.new

    if current_user.belongs_to_discussion?(@discussion.id) && @post.save
      @discussion.last_updated = Time.now
      @discussion.save
      flash[:success] = "Post created!"
      redirect_to thread_path(@discussion)
    else
      flash[:danger] = "There was a problem with your Post!"
      render 'discussions/show'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if current_user.created_post?(@post.id)
    flash[:success] = "You have deleted your post!"
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
