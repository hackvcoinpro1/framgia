class Suppervisor::SubjectsController < ApplicationController
  layout "suppervisor_layout"
  before_action :logged_in_user
  before_action :verify_suppervisor
  def index
    @subjects = Subject.paginate(page: params[:page], per_page: Settings.per_page.config)
  end
end
