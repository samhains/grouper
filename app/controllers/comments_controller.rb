class CommentsController < ApplicationController 
  before_action :require_user
  def create
    @post = Post.find(params[:post_id])
    @discussion = @post.discussion
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to discussion_path(@discussion)
    else
      flash[:danger] = "Your comment needs text"
      render 'discussions/show'
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
