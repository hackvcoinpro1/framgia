class Course < ApplicationRecord
  has_many :course_subject
  has_many :user_course
  default_scope ->{order(created_at: :desc)}
end
