class CreateCourseSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :course_subjects do |t|
      t.integer :status
      t.date :date_start
      t.date :date_end
      t.references :course, foreign_key: true
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
