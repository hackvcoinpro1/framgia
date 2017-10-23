class ChangeNameColumnToUserTasks < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_tasks, :user_id, :user_subject_id
  end
end
