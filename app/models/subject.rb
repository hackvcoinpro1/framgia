class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  has_many :having, through: :user_subjects, source: :user
  has_many :task
  has_many :user_subject

  default_scope ->{order(created_at: :desc)}
  scope :without_course, ->(course){where.not id: course.subject_ids}
end
