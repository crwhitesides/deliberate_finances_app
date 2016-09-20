class User < ActiveRecord::Base
  has_many :user_plans
  has_many :plans, through: :user_plans
  has_many :comments

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }
end
