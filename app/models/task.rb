class Task < ApplicationRecord
  belongs_to :subject
  has_many :user_task
  scope :alphabet_name, ->{order :name}
end
