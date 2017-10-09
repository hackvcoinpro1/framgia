class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember_params user
      redirect_back_or user
    else
      flash.now[:danger] = t "sessions.login.login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def remember_params user
    params[:session][:remember_me] == Settings.sessions.check ? remember(user) : forget(user)
  end
end
