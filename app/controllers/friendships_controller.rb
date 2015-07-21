class FriendshipsController < ApplicationController
  before_action :require_user

  def index
    @friendships = current_user.friendships
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    @user = User.find(params[:friend_id])
    if @friendship.save
      flash[:success] = "You have added a friend!"
      redirect_to user_path(@user)
    else
      @posts = @user.posts
      flash[:danger] = "You were unable to add friend!"
      render 'users/show'
    end
  end

  def destroy
    @friendship = Friendship.find_by(friend_id: params[:id])
    @user = @friendship.friend
    @friendship.destroy
    flash[:success] = "You have deleted friend!"
    redirect_to user_path(@user)
  end



end
