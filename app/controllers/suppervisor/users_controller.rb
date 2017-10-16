class Suppervisor::UsersController < ApplicationController
  layout "suppervisor_layout"
  before_action :logged_in_user
  before_action :load_user, except: %i(new index create)
  before_action :verify_suppervisor

  def show; end

  def index
    @users = User.alphabet_name.paginate page: params[:page],
      per_page: Settings.per_page.config
  end

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

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.edit.update_success"
      redirect_to suppervisor_user_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.destroy.delete_success"
    else
      flash[:danger] =  t "users.destroy.delete_error"
    end
    redirect_to suppervisor_users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :university, :organization, :program, :avatar
  end
end
