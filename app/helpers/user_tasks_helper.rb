module UserTasksHelper
  def build_user_task us, task_id
    UserTask.find_by(user_subject_id: us.id, task_id: task_id)
  end

  def check_status_ut us, task_id
    user_task = us.user_tasks.find_by(task_id: task_id)
    case true
    when user_task.init?
      @status = t ("public.init")
    when user_task.in_progress?
      @status = t ("public.in_progress")
    else
      @status = t ("public.finish")
    end
    @class = "status-#{@status}"
  end

  def check_status_btn_ut us, task_id
    user_task = us.user_tasks.find_by(task_id: task_id)
    case true
    when user_task.init?
      @next_status = t ("public.in_progress")
      @btn_class = "btn btn-success pull-right"
    when user_task.in_progress?
      @next_status = t ("public.finish")
      @btn_class = "btn btn-danger pull-right"
    else
      @next_status = t ("public.finish")
      @btn_class = "btn status-btn-dis pull-right"
    end
  end
end
