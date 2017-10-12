class User < ApplicationRecord
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :user_subject
  has_many :user_task
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user.email.maximum_length},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.password.minimum_length}, allow_nil: true
  mount_uploader :avatar, AvatarUploader

  scope :alphabet_name, ->{order :name}
  scope :without_suppervisor, ->{where suppervisor: nil}
  scope :with_suppervisor, ->{where suppervisor: true}
  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def create_password_default
    self.password_digest = User.digest Settings.user.password.default_password
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attributes(remember_digest: nil)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
