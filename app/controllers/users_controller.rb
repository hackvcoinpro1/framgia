class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(edit update)
  before_action :load_user, only: %i(edit update show)
  before_action :correct_user, only: %i(update)

  def show; end

  def index
    @users = User.without_suppervisor.alphabet_name.paginate page: params[:page],
      per_page: Settings.per_page.config
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.edit.update_success"
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation,
      :university, :organization, :program, :avatar
  end
end
