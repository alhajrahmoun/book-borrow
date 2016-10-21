class Api::UsersController < ApplicationController
	respond_to :json
	before_action :authenticate_user!
	def index 
		render json: {users: User.all}
	end

	def show
		render json: {user: [User.find(params[:id])]}
	end

   def get_info
    user_info = []
    user_info.push(id: current_user.id, name: current_user.name, points: current_user.points, group: current_user.borrow_group)
    render json: {user_info: user_info}
   end

   def save_fcm_token
   	@user = current_user
   	@user.fcm_token = params[:fcm_token]
   	if @user.save
   		render json: {message: ["fcm token saved"]}
   	else
   		render json: {error: ["error saving token"]}
   	end
   end
end
