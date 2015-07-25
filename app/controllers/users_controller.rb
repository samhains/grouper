class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]

  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end

  def edit
    @user = current_user
  end


  def update
    @user = current_user
    @user.update(user_params)
    if @user.save
      flash[:success] = "User has been updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end

  end

  def search
    @users = User.search_by_name(params[:name])
    respond_to do |format| 
      format.html
      format.js { render json: @users }
    end
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
   @posts = @user.posts.page params[:page]
   @likes = @user.likes.limit(6)
  end


  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :bio, :time_zone)
  end
end

