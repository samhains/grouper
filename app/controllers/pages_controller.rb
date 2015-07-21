class PagesController < ApplicationController
  def portal
    if logged_in?
      @discussions = current_user.discussions.limit(10)
      @recent_discussions = current_user.recent_discussions
      @posts = Post
      .where(discussion_id: current_user.discussions)
      .order('updated_at DESC').page params[:page]
      @comment = Comment.new

    else
      @recent_discussions = Discussion.order('last_updated DESC').limit(6)
    end
  end
end
