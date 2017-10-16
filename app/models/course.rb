class Course < ApplicationRecord
  has_many :course_subjects, dependent: :destroy
  has_many :having, through: :course_subjects, source: :subject
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  default_scope ->{order(created_at: :desc)}

  def have subject
    having << subject
  end

  def unhave subject
    having.delete subject
  end
end
