class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject
  validates :course_id, presence: true
  validates :subject_id, presence: true

  enum status: [:init, :in_progress, :finish]

  scope :not_status_init, ->{where.not status: "init"}
end
