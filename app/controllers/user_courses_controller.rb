class UserCoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :check_params, only: %i(create destroy)

  def create
    if @course.have_user @user
      respond_to do |format|
        format.html{redirect_to edit_course_path(@course)}
        format.js
      end
    else
      flash[:danger] = t "controllers.user_courses.flash_danger_create"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    if @course.unhave_user @user
      respond_to do |format|
        format.html{redirect_to edit_course_path(@course)}
        format.js
      end
    else
      flash[:danger] = t "controllers.user_courses.flash_danger_destroy"
      redirect_back fallback_location: root_path
    end
  end

  def check_params
    @user = User.find_by id: params[:user_id]
    @course = Course.find_by id: params[:course_id]
    unless @course || @user
      flash[:danger] = t "controllers.course_users.flash_danger"
      redirect_to root_path
    end
  end
end
