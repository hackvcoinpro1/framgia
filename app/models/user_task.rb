class UserTask < ApplicationRecord
  belongs_to :user_subject
  belongs_to :task
  validates :user_subject_id, presence: true
  validates :task_id, presence: true
end
