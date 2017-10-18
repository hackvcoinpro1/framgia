class Suppervisor::SubjectsController < ApplicationController
  layout "suppervisor_layout"
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :load_subject, only: %i(show destroy)
  before_action :load_courses, :load_trainers_trainees, :load_tasks, only: %i(show)

  def index
    @subjects = Subject.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def show; end

  def new; end

  def create; end

  def destroy; end

  private

  def load_courses
    @courses = @subject.courses.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def load_trainers_trainees
    @trainers = @subject.users.with_suppervisor.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
    @trainees = @subject.users.without_suppervisor.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
  end

  def load_tasks
    @tasks = @subject.task.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
  end

  def subject_params
    params.require(:subject).permit(:name, :description)
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "subjects.show.flash_danger"
    redirect_to suppervisor_subjects_path
  end
end
