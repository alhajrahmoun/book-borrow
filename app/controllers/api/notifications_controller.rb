class Api::NotificationsController < ApplicationController
  def index
  	notifications = Notification.where(user_id: User.find(1))
  	render json: {notifications: notifications}
  end
end
