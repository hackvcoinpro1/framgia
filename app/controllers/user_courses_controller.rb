class UserCoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :check_params, only: %i(create destroy)
  before_action :check_user_course, only: %i(create)
  before_action :check_user_inprogress, only: %i(create)
  before_action :course_finish
  def create
    if @course.have_user @user
      flash[:success] = t "controllers.user_courses.flash_success_create"
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
      flash[:success] = t "controllers.user_courses.flash_success_destroy"
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

  def check_user_course
    if UserCourse.find_by course_id: @course.id, user_id: @user.id
      flash[:danger] = t "controllers.user_courses.flash_exists"
      redirect_to edit_course_path(@course)
    end
  end

  def check_user_inprogress
    return if @user.suppervisor?
    if !@user.courses.nil? || !@user.courses.not_status_init.blank?
      flash[:danger] = t "controllers.user_courses.user_inprogress"
      redirect_to edit_course_path(@course)
    end
  end
end
