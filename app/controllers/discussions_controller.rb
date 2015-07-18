class DiscussionsController < ApplicationController 
  before_action :require_user
  before_action :find_discussion, only: [:leave, :join]
  
  #Thread was a reserved word so discussion was used for controller stuff
  #for the purpose of this app threads and discussions are the same thing

  def index
    @discussions = Discussion.all.order('last_updated DESC')
  end

  def my_discussions
    @discussions = current_user.get_discussions
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.last_updated = Time.now
    if @discussion.save
      flash[:success] = "New Discussion Created!"
      redirect_to discussion_path(@discussion)
    else
      flash[:danger] = "There was a problem with your new discussion"
      render 'discussions/new'
    end
  end
  
  def show
    @discussion = Discussion.find(params[:id])
    @posts = @discussion.posts
    @post = Post.new
    @comment = Comment.new
  end

  def join
    current_user.discussions << @discussion 
    current_user.save
    flash[:success] = "Welcome to #{ @discussion.name }"
    redirect_to discussion_path(@discussion)
  end

  def leave
    current_user.discussions.delete @discussion
    redirect_to root_path
  end

  private
  def find_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def discussion_params
    params.require(:discussion).permit(:name, :description)
  end
end
