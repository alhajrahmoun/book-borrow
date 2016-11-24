class DashboardController < ApplicationController
  def index
  	@users = User.where(approved: true)
  end

  def begin_new_round
  	#book_available = true
  	#subscriber_id = null
  	#users_borrow_times +1 if active
  	#current_round = 10
  	#calculate_points
  end
end
