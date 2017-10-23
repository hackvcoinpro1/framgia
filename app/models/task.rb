class Task < ApplicationRecord
  belongs_to :subject
  has_many :user_tasks
  has_many :user_subjects, through: :user_tasks
  scope :alphabet_name, ->{order :name}
end
