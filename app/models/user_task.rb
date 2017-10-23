class UserTask < ApplicationRecord
  belongs_to :user_subject
  belongs_to :task
end
