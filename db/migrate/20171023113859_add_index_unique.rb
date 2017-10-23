class AddIndexUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :user_courses, [:course_id, :user_id], unique: true
    add_index :user_subjects, [:user_id, :course_subject_id], unique: true
    add_index :user_tasks, [:task_id, :user_subject_id], unique: true
  end
end
