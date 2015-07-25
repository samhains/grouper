class NotificationsController < ApplicationController
  before_action :require_user
  after_action :check_notifications
  def index
    @notifications = current_user.notifications.page params[:page]
  end

  private

  def check_notifications
    current_user.check_notifications
  end
end
