class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :goals, dependent: :destroy
  has_one :profile, dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password
end
