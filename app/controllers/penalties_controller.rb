class PenaltiesController < ApplicationController
  autocomplete :user, :first_name, :extra_data => [:last_name], :display_value => :name
  def new
  	@penalty = Penalty.new
  end

  def create
  	@penalty = Penalty.new(penalty_params)
  	if @penalty.save
  		user = User.find(@penalty.user_id)
  		user.points_calculation(@penalty.points)
  		redirect_to user_path(user)
  	end
  end

  def edit
  end

  private
  def penalty_params
  	params.require("penalty").permit(:description, :points, :user_id)
  end
end
