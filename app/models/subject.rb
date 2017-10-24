class Subject < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :courses, through: :course_subjects
  has_many :user_courses, through: :courses
  has_many :users, through: :user_courses
  has_many :having_course, through: :course_subjects, source: :course

  has_many :tasks, dependent: :destroy

  default_scope ->{order(created_at: :desc)}
  scope :without_course, ->(course){where.not id: course.subjects.pluck(:id)}

  def unhave_course course
    having_course.delete course
  end
end
