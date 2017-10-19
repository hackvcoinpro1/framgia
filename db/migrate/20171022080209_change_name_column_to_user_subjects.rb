class ChangeNameColumnToUserSubjects < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_subjects, :subject_id, :course_subject_id
  end
end
