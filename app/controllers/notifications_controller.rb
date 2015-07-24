class NotificationsController < ApplicationController
  before_action :require_user
  def index
    @notifications = current_user.notifications
  end
end
