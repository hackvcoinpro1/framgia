class CourseSubject < ApplicationRecord
  belongs_to :course
  belongs_to :subject

  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  has_many :having, through: :user_subjects, source: :user

  scope :not_status_init, ->{where.not status: :init}

  validates :course_id, presence: true
  validates :subject_id, presence: true

  enum status: [:init, :in_progress, :finish]

  def have user_ids
    user_subjects.create user_id: user_ids, status: I18n.t("public.in_progress")
  end
end
