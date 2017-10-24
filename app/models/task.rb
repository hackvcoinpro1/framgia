class Task < ApplicationRecord
  belongs_to :subject
  has_many :user_tasks, dependent: :destroy
  has_many :user_subjects, through: :user_tasks

  has_many :users, through: :user_tasks
  has_many :having, through: :user_tasks, source: :user

  scope :alphabet_name, ->{order :name}

  def delete_task
    destroy unless UserTask.find_by task_id: self.id
  end
end
