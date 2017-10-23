class CourseSubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :check_params, only: %i(create destroy update)
  before_action :load_object, only: %i(update destroy)
  before_action :course_finish
  def create
    date = Date.strptime(params[:course_subject][:date_start], "%m/%d/%Y")
    if @course.have @subject, date
      flash[:success] = t "controllers.course_subjects.flash_success_create"
      respond_to do |format|
        format.html{redirect_to edit_course_path(@course)}
        format.js
      end
    else
      flash[:danger] = t "controllers.course_subjects.flash_danger_create"
      redirect_to edit_course_path(@course)
    end
  end

  def destroy
    if @sb_course.init?
      if @course.unhave @subject
        flash[:success] = t "controllers.course_subjects.flash_success_destroy"
        respond_to do |format|
          format.html{redirect_to edit_course_path(@course)}
          format.js
        end
      else
        flash[:danger] = t "controllers.course_subjects.flash_danger_destroy"
      end
    else
      flash[:danger] = t "controllers.course_subjects.flash_danger_destroy"
      redirect_to edit_course_path(@course)
    end
  end

  def update
    @sb_course.status = params[:status]
    @sb_course.date_end = Time.zone.now
    if @sb_course.save
      flash[:success] = t "controllers.course_subjects.flash_success_update"
      save_user_subject if @sb_course.in_progress?
    else
      flash[:danger] = t "controllers.course_subjects.flash_danger_update"
    end
    redirect_to @course
  end

  def check_params
    @subject = Subject.find_by id: params[:subject_id]
    @course = Course.find_by id: params[:course_id]
    unless @course || @subject
      flash[:danger] = t "controllers.course_subjects.flash_danger"
      redirect_to root_path
    end
  end

  def load_object
    @sb_course = CourseSubject.find_by course_id: params[:course_id], subject_id: params[:subject_id]
    unless @sb_course
      flash[:danger] = t "controllers.course_subjects.flash_danger"
      redirect_to root_path
    end
  end

  def save_user_subject
    trainees = @course.users.without_suppervisor.pluck(:id)
    tasks = @subject.task.pluck(:id)
    trainees.each do |id|
      @sb_user = @sb_course.have id
      tasks.each do |id_task|
        @sb_user.have id_task
      end
    end
  end
end
