class CoursesController < ApplicationController
  def index
    @courses = Course.paginate(page: params[:page], per_page: Settings.per_page.config)
  end
end
