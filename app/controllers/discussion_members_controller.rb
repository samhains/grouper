class DiscussionMembersController < ApplicationController
  before_action :require_user
  before_action :find_discussion

  def create
    current_user.discussions << @discussion 
    current_user.save
    flash[:success] = "Welcome to #{ @discussion.name }"
    redirect_to thread_path(@discussion)
  end

  def destroy
    current_user.discussions.delete @discussion
    redirect_to root_path
  end

  private

  def find_discussion
    @discussion = Discussion.find(params[:thread_id])
  end
end
