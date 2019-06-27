# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_action :verify_authenticity_token

  alias_method :current_user, :current_api_v1_user
  alias_method :authenticate_user!, :authenticate_api_v1_user!
  alias_method :user_signed_in?, :api_v1_user_signed_in?
end
