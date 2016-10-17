class DashboardController < ApplicationController
  def index
  	@users = User.where(approved: true)
  end
end
