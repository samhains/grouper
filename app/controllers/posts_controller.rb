class PostsController < ApplicationController
  before_action :require_user
  before_action :set_group, only: [:create, :destroy]

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.group = @group
    @posts = @group.posts
    @comment = Comment.new

    if current_user.belongs_to_group?(@group.id) && @post.save
      flash[:success] = "Post created!"
      redirect_to group_path(@group)
    else
      flash[:danger] = "There was a problem with your Post!"
      render 'groups/show'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if current_user.created_post?(@post.id)
    flash[:success] = "You have deleted your post!"
    redirect_to group_path(@group)
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :group_id)
  end
end
