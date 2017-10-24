class Suppervisor::SubjectsController < ApplicationController
  layout "suppervisor_layout"
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :load_subject, except: %i(index new create)
  before_action :load_courses, :load_trainers_trainees, :load_tasks, only: %i(show destroy edit)

  def index
    @subjects = Subject.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def show; end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "subjects.new.flash_success"
      redirect_to suppervisor_subjects_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subjects.update.flash_success"
      redirect_to request.referer
    else
      flash[:danger] = t "subjects.update.flash_danger"
      render :edit
    end
  end

  def destroy
    course_subjects = @subject.course_subjects
    if course_subjects.nil? || course_subjects.not_status_init.blank?
      delete_subject
    else
      flash[:danger] = t "subjects.destroy.flash_danger"
    end
    redirect_to suppervisor_subjects_path
  end

  private

  def delete_subject
    ActiveRecord::Base.transaction do
      @subject.unhave_course @courses
      Subject.destroy(@subject.id)
    end
    flash[:success] = t "subjects.destroy.delete_success"
  rescue
    flash[:error] = t "subjects.destroy.flash_error"
  end

  def load_courses
    @courses = @subject.courses
    @total_courses = @subject.courses.size
  end

  def load_trainers_trainees
    @total_trainers = @subject.users.with_suppervisor.size
    @total_trainees = @subject.users.without_suppervisor.size
    @total_member = @subject.users.size
    @trainers = @subject.users.with_suppervisor.alphabet_name
    @trainees = @subject.users.without_suppervisor.alphabet_name
    @member = @subject.users
  end

  def load_tasks
    @total_tasks = @subject.tasks.size
    @tasks = @subject.tasks.alphabet_name
  end

  def subject_params
    params.require(:subject).permit :name, :description
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "subjects.show.flash_danger"
    redirect_to suppervisor_subjects_path
  end
end
