class User < ApplicationRecord
  has_many :user_course
  has_many :user_subject
  has_many :user_task
end
