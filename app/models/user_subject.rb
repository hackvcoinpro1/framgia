class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject
  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks

  validates :user_id, presence: true
  validates :course_subject_id, presence: true

  enum status: [:init, :in_progress, :finish]

  def have task_ids
    user_tasks.create task_id: task_ids, status: I18n.t("public.init")
  end
end
