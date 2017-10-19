class UserSubject < ApplicationRecord
  belongs_to :user
  belongs_to :course_subject
  validates :user_id, presence: true
  validates :subject_id, presence: true
end
