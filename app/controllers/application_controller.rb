class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Devise::Controllers::Helpers
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :first_name, :last_name, :gender, :birthday, :education_level, :specialization, :mobile, :current_address, :favorite_language, :favorite_book_type, :friend_name])
  end
end
