class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :task
  has_many :user_subject
  scope :find_subjects_not_in_course, ->(course){where("id NOT IN (?)", course.subject_ids)}
end
