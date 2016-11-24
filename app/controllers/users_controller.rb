class UsersController < ApplicationController
  require 'fcm'
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.uid = user_params['email']
    @user.password = user_params['mobile']
    @user.password_confirmation = user_params['mobile']
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

   def search
    @users = User.search_by_name(params[:search_user])
  end

  def need_approval
    @users = User.where(approved: false)
  end

  def control_approval
    @user = User.find(params[:id])
    @user.approved = true
    send_notification(@user.fcm_token)
    if @user.save
      redirect_to users_need_approval_path
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to root_path
  end

  private
  def user_params
    params.require("user").permit(:email, :first_name, :last_name, :gender, :birthday, :education_level, :specialization, :mobile, :current_address, :favorite_language, :favorite_book_type, :friend_name, :points, :borrow_times, :borrow_group, :approved)
  end

  def send_notification(notification_dest)
    fcm = FCM.new("AIzaSyC7EB-g9d49wRC-Ki7UiPy5qry0QOWw4SE")
    registration_ids= [notification_dest] # an array of one or more client registration tokens
    options = {notification: {body: "تم تفعيل حسابك من قبل المشرف"}}
    puts response = fcm.send(registration_ids, options)
  end

end
