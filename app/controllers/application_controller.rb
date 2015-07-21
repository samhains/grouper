class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :is_friend?

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def is_friend?(friend_id)
    return unless friend_id
    friend = User.find(friend_id)
    current_user.friendships.map(&:friend).include?(friend)
  end

  def logged_in?
    !!session[:user_id]
  end

  def require_user
    unless logged_in?
      redirect_to login_path
    end
  end
end

