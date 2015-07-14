class PostsController < ApplicationController
  before_action :require_user
  before_action :set_group, only: [:create]

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.group = @group
    @posts = @group.posts
    @comment = Comment.new

    if @post.save
      flash[:success] = "Post created!"
      redirect_to group_path(@group)
    else
      flash[:danger] = "There was a problem with your Post!"
      render 'groups/show'
    end
  end

  private
  def set_group
    @group = Group.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :group_id)
  end
end
