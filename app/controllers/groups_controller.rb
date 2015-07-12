class GroupsController < ApplicationController 
  before_action :require_user
  before_action :find_group, only: [:leave, :join]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "New Group Created!"
      redirect_to group_path(@group)
    else
      flash[:danger] = "There was a problem with your new group"
      render 'groups/new'
    end
  end
  
  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
    @post = Post.new
  end

  def join
    current_user.groups << @group 
    current_user.save
    flash[:success] = "Welcome to #{ @group.name }"
    redirect_to group_path(@group)
  end

  def leave
    current_user.groups.delete @group
    redirect_to root_path
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
