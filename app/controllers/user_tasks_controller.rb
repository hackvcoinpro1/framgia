class UserTasksController < ApplicationController
  before_action :logged_in_user, only: %i(update)
  before_action :load_user_task, only: %i(update)
  before_action :check_finish, only: %i(update)

  def update
    if @user_task.update_attributes user_task_params
      flash[:success] = t "user_task.update.flash_success"
    else
      flash[:danger] = t "user_task.update.flash_danger"
    end
    redirect_to request.referer
  end

  private

  def user_task_params
    params.permit :status
  end

  def check_finish
    tasks = @subject.tasks.size
    user_tasks = @user_subject.user_tasks.status_finish.size
    if user_tasks == (tasks-1) && params[:status] == "finish"
      @user_subject.finish_user_subject
    end
  end

  def load_user_task
    debugger
    @user_task = UserTask.find_by id: params[:id]
    @user_subject = UserSubject.find_by id: params[:user_subject_id]
    @subject = Subject.find_by id: params[:subject_id]
    unless @user_task || @user_subject || @subject
      flash[:danger] = t "user_task.danger.danger_load_task"
      redirect_to request.referer
    end
  end
end
