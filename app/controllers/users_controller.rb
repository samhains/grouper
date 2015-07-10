class UsersController < ApplicationController
  before_action :require_user, only: [:portal]

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

  def portal
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end
end
