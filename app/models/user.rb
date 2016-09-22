class User < ActiveRecord::Base
  has_many :user_plans
  has_many :plans, through: :user_plans
  has_many :comments

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  has_secure_password
  # validates :password, length: { minimum: 6 }

  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      # user.location = auth_hash['info']['location']
      # user.image_url = auth_hash['info']['image']
      # user.url = auth_hash['info']['urls']['Twitter']
      user.save!
      user
    end
  end

end
