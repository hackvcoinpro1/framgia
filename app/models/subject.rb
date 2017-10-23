class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :task

  default_scope ->{order(created_at: :desc)}
  scope :without_course, ->(course){where.not id: course.subject_ids}
end
