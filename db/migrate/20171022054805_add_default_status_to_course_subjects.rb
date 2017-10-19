class AddDefaultStatusToCourseSubjects < ActiveRecord::Migration[5.1]
  def change
    change_column :course_subjects, :status, :integer, default: 0
  end
end
