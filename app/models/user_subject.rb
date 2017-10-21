class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject

  has_many :user_tasks
  has_many :tasks, through: :course_subjects

  validates :user_id, presence: true
  validates :course_subject_id, presence: true
end
