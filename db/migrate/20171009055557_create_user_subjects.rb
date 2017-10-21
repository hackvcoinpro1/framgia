class CreateUserSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :user_subjects do |t|
      t.integer :status
      t.references :user, foreign_key: true
      t.references :course_subject, foreign_key: true

      t.timestamps
    end
  end
end
