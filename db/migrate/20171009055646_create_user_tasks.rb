class CreateUserTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tasks do |t|
      t.integer :status
      t.datetime :date_receive
      t.datetime :date_finish
      t.references :user_subject, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
