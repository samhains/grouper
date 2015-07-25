class CommentsController < ApplicationController 
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @discussion = @post.discussion
    @comment = Comment.new(comment_params)

    update_time_stamps

    @comment.user = current_user
    @comment.post = @post

    if @comment.save
      redirect_to :back
    else
      flash[:danger] = "Your comment needs text"
      render 'discussions/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @discussion = @comment.post.discussion
    @comment.destroy if current_user.created_comment?(@comment.id)
    flash[:success] = "You have deleted your comment!"
    redirect_to :back
  end

  private

  def update_time_stamps
    @post.updated_at = Time.now
    @post.save
    @discussion.last_updated = Time.now
    @discussion.save
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
