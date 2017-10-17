class Suppervisor::SubjectsController < ApplicationController
  layout "suppervisor_layout"
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :load_subject, only: %i(show destroy)

  def index
    @subjects = Subject.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def show
    load_courses @subject
    load_trainers_trainees @subject
    load_tasks @subject
  end

  def new; end

  def create; end

  def destroy; end

  private

  def load_courses subject
    @courses = subject.courses.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def load_trainers_trainees subject
    @trainers = subject.users.with_suppervisor.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
    @trainees = subject.users.without_suppervisor.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
  end

  def load_tasks subject
    @tasks = subject.task.alphabet_name.paginate(page: params[:page],
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
