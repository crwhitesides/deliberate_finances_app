class User < ActiveRecord::Base
  has_many :user_plans
  has_many :plans, through: :user_plans
  has_many :comments

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = "#{auth_hash['info']['nickname']}@test.com" # Lines 17-19 are necessary because my validations require an email and password to log in
    user.password = '7LZnDFxGoUdbk)TT=JTmTVFQnPm{3A'
    user.password_confirmation = '7LZnDFxGoUdbk)TT=JTmTVFQnPm{3A'
    user.save!
    user
  end

end
