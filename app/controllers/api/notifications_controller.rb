class Api::NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
  	notifications = Notification.where(user_id: current_user.id)
  	render json: {notifications: notifications}
  end
end
