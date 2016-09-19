class User < ActiveRecord::Base
  has_many :user_plans
  has_many :plans, through: :user_plans

  has_many :comments
end
