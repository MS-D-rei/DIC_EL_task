class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'Please log in'
    redirect_to login_url
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
