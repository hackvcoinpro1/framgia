class Suppervisor::TasksController < ApplicationController
  before_action :logged_in_user
  before_action :verify_suppervisor
  before_action :load_task, only: %i(destroy edit update)
  before_action :load_subject_task, only: %i(edit destroy)
  before_action :load_subject, only: %i(new)

  def show; end

  def new
    @task = Task.new
    store_referer
  end

  def create
    @task = Task.new task_params
    if @task.save
      respond_to do |format|
        format.html{redirect_back_or nil}
        format.js
      end
    else
      flash[:danger] = t "tasks.danger.danger_add_task"
      redirect_to suppervisor_subjects_path
    end
  end

  def edit
    store_referer
  end

  def update
    if @task.update_attributes task_params
      flash[:success] = t "tasks.success.success_update_task"
      redirect_back_or nil
    else
      render request.referer
    end
  end

  def destroy
    if @task.delete_task
      respond_to do |format|
        format.html{redirect_to request.referer}
        format.js
      end
    else
      flash[:danger] = t "tasks.danger.danger_delete_task"
      redirect_to suppervisor_subjects_path
    end
  end

  private

  def load_subject_task
    @subject = @task.subject
    return if @subject
    flash[:danger] = t "tasks.danger.danger_subjects"
    redirect_to request.referer
  end

  def load_task
    @task = Task.find_by id: params[:id]
    return if @task
    flash[:danger] = t "tasks.danger.danger_subjects"
    redirect_to request.referer
  end

  def load_subject
    @subject = Subject.find_by id: params[:subject_id]
    redirect_to request.referer unless @subject
  end

  def task_params
    params.require(:task).permit :name, :description, :subject_id
  end
end
