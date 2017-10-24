class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject

  has_many :user_tasks
  has_many :tasks, through: :course_subjects
  enum status: [:in_progress, :finish]
  validates :user_id, presence: true
  validates :course_subject_id, presence: true

  def finish_user_subject
    update_attributes(status: :finish)
  end
end
