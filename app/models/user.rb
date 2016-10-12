class User < ActiveRecord::Base
  has_many :user_plans
  has_many :plans, through: :user_plans
  has_many :payments

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def self.from_omniauth(auth)
    user = find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    if user.new_record?
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = SecureRandom.hex(20)
      user.password_confirmation = user.password
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
      user.create_initial_set_of_plans
      user
    else
      user
    end
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
