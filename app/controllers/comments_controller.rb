class CommentsController < ApplicationController 
  before_action :require_user
  def create
    @post = Post.find(params[:post_id])
    @group = @post.group
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      redirect_to group_path(@group)
    else
      flash[:danger] = "Your comment needs text"
      render 'groups/show'
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
