module SubjectsHelper
  def subject_column_for_suppervisor
    Subject.column_names - %w(id created_at updated_at) + %w(action)
  end

  def find_cs course, subject
    CourseSubject.find_by(course_id: course.id, subject_id: subject.id)
  end

  def check_progess trainee, total_tasks, course_subject
    user_subject = UserSubject.find_by(user_id: trainee.id, course_subject_id: course_subject.id)
    if user_subject.nil?
      total_user_task = 0
    else
      total_user_task = user_subject.user_tasks.not_status_init.size
    end

    if total_tasks == 0
      @progess = 0
    else
      @progess = (total_user_task.to_f/total_tasks)*100
    end

  end
end
