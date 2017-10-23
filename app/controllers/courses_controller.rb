class CoursesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_suppervisor, except: %i(show index)
  before_action :load_course, except: %i(new create index)
  before_action :course_finish, only: %i(update)
  def index
    @courses = Course.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def show
    load_subjects @course
    load_trainees @course
    load_trainers @course
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
    if @course.init?
      if @course.destroy
        flash[:success] = t "controllers.courses.flash_success_destroy"
      else
        flash[:danger] = t "controllers.courses.flash_danger_destroy"
      end
    else
      flash[:danger] = t "controllers.courses.in_progress"
    end
    redirect_to courses_path
  end

  def edit
    load_subjects @course
    load_trainees @course
    load_trainers @course
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "controllers.courses.flash_success_update"
      redirect_to @course
    else
      flash[:danger] = t "controllers.courses.flash_danger_update"
      render :edit
    end
  end

  def load_subjects course
    @subjects = course.subjects
    @all_subjects = Subject.all
    @all_subjects = @all_subjects.without_course course if @subjects.present?
  end

  def load_trainers course
    @trainers = course.users.with_suppervisor.alphabet_name
    @all_trainers = User.with_suppervisor.alphabet_name
    @all_trainers = @all_trainers.without_course course if @trainers.present?
  end

  def load_trainees course
    @trainees = course.users.without_suppervisor.alphabet_name
    @all_trainees = User.without_suppervisor.alphabet_name
    @all_trainees = @all_trainees.without_course course if @trainees.present?
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :status)
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "controllers.courses.flash_danger"
    redirect_to :root
  end
end
