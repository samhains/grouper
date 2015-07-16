class UsersController < ApplicationController
  before_action :require_user, only: [:portal, :show]

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have sucessfully Logged In!"
      redirect_to root_path
    else
      flash[:danger] = "There was a problem with your Registration"
      render 'users/new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
 
  end

  def portal
    
    @discussions = current_user.discussions.limit(10)
    recent_discussions_count = 6 - @discussions.count
    if recent_discussions_count > 0
      @recent_discussions = Discussion.order('last_updated DESC').limit(recent_discussions_count)
    end
    @posts = current_user.recent_posts
    @comment = Comment.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :bio)
  end
end

