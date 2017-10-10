class CoursesController < ApplicationController
  before_action :load_course, only: %i(show)

  def index
    @courses = Course.paginate(page: params[:page], per_page: Settings.per_page.config)
  end

  def show; end

  private

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:danger] = t "controllers.courses.flash_danger"
    redirect_to :root
  end
end
