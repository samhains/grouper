class GroupsController < ApplicationController 
  before_action :require_user

  def index
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
  end

  def join
    @group = Group.find(params[:group_id])
    current_user.groups << @group 
    current_user.save
    render 'groups/show' 
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
