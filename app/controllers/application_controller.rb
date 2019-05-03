class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery
  before_action :authenticate_user!

  def current_user
    @current_user ||= User.first
  end

  def authenticate_user!
    current_user.nil? ? auth_error : current_user
  end

  def auth_error
    render json:
     {
       errors: {
         status: 403,
         messages: "ログインしてください",
       },
     }
  end
end
