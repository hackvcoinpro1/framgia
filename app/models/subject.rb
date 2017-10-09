class Subject < ApplicationRecord
  has_many :course_subject
  has_many :task
  has_many :user_subject
end
