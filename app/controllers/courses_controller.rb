class CoursesController < ApplicationController
  before_action :load_course, only: %i(show destroy)
  def index
    @courses = Course.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def show
    load_subjects @course
    load_trainers_trainees @course
    @all_subjects = Subject.all
    @all_subjects = @all_subjects.find_subjects_not_in_course @course if @subjects.present?
  end

  def new
    @course = Course.new
    @subjects = Subject.all
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "controllers.courses.flash_success_create"
      redirect_to courses_path
    else
      render :new
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "controllers.courses.flash_success_destroy"
    else
      flash[:danger] = t "controllers.courses.flash_danger_destroy"
    end
    redirect_to courses_path
  end

  def load_subjects course
    @subjects = course.subjects.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def load_trainers_trainees course
    @trainers = course.users.with_suppervisor.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
    @trainees = course.users.without_suppervisor.alphabet_name.paginate(page: params[:page],
      per_page: Settings.per_page.config)
  end

  private

  def course_params
    params.require(:course).permit(:name, :description)
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "controllers.courses.flash_danger"
    redirect_to :root
  end
end
