class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

private
  def sign_up_params
    params.permit(:name, :email, :password)
  end

  def account_update_params
    params.permit(:name, :email)
  end

  # def sign_up_params
  #   @invited_by = params[:invited_by]
  #   @invited_email = params[:invited_email]
  #   params.permit([*params_for_resource(:sign_up)], :token, :confirm_success_url)
  # end
end
