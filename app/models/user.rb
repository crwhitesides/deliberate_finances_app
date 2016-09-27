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

  def create_initial_set_of_plans
    12.times { |i| self.plans.create(date: Date.today + i.month) }
  end

  def current_twelve_months_of_plans
    if Date.today.month > self.plans.last(12).first.date.month
      last_month = self.plans.last(12).last.date
      self.plans.create(date: (last_month + 1.month))
      self.plans.last(12)
    else
      self.plans.last(12)
    end
  end

  def past_plans
    self.plans.map do |plan|
      if plan.date < current_plan.date
        plan
      end
    end.compact
  end

  def current_plan
      current_twelve_months_of_plans.first
  end
end
