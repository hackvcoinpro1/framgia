class SubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :load_subject, only: %i(show)
  before_action :load_course, only: %i(show)
  before_action :load_trainers_trainees, :load_tasks, only: %i(show)
  before_action :load_status_subject, only: %i(show)


  def show; end

  private

  def load_trainers_trainees
    @total_trainers = @course.users.with_suppervisor.size
    @total_trainees = @course.users.without_suppervisor.size
    @total_member = @course.users.size
    @trainers = @course.users.with_suppervisor.alphabet_name
    @trainees = @course.users.without_suppervisor.alphabet_name
  end

  def load_tasks
    @total_tasks = @subject.tasks.size
    @tasks = @subject.tasks.alphabet_name
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:danger] = t "subjects.show.flash_danger"
    redirect_to request.referer
  end

  def load_status_subject
    debugger
    @course_subject = CourseSubject.find_by(course_id: params[:course_id], subject_id: params[:id])
    if @course_subject.nil?
      redirect_to request.referer
    elsif UserSubject.find_by(user_id: current_user.id, course_subject_id: @course_subject.id).blank?
      @status_subject = "init"
    else
     @user_subject = UserSubject.find_by(user_id: current_user.id, course_subject_id: @course_subject.id)
     @status_subject = @user_subject.status
   end
 end

 def load_progess

 end

 def load_subject
  @subject = Subject.find_by id: params[:id]
  return if @subject
  flash[:danger] = t "subjects.show.flash_danger"
  redirect_to request.referer
end

end
