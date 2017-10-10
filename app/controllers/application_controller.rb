class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "sessions.login.please_login"
    redirect_to login_url
  end

  def verify_suppervisor
    redirect_to :root unless current_user.suppervisor?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "users.load_user.error"
    redirect_to users_path
  end
end
