class CourseSubjectsController < ApplicationController
  before_action :check_params, only: %i(create destroy)

  def create
    @course.have @subject
    respond_to do |format|
      format.html{redirect_to @course}
      format.js
    end
  end

  def destroy
    @course.unhave @subject
    respond_to do |format|
      format.html{redirect_to @course}
      format.js
    end
  end

  def check_params
    @subject = Subject.find_by id: params[:subject_id]
    @course = Course.find_by id: params[:course_id]
    unless @course || @subject
      flash[:danger] = t "controllers.course_subjects.flash_danger"
      redirect_to root_path
    end
  end
end
