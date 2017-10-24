class UserTask < ApplicationRecord
  belongs_to :user_subject
  belongs_to :task
  enum status: [:init, :in_progress, :finish]
  validates :user_subject_id, presence: true
  validates :task_id, presence: true
  scope :status_finish, ->{where status: :finish}
  scope :not_status_init, ->{where.not status: :init}
end
