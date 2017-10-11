class Suppervisor::UsersController < ApplicationController
  before_action :logged_in_user, only: %i(new create destroy)
  before_action :verify_suppervisor, only: %i(new create destroy)
  before_action :load_user, only: %i(destroy)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    @user.create_password_default
    if @user.save
      flash[:success] = t "users.signup.success"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.delete_success"
    else
      flash[:danger] =  t "users.destroy.delete_error"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :university, :organization, :program
  end
end
