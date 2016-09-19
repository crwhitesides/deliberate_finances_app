class Plan < ActiveRecord::Base
  has_many :user_plans
  has_many :purchase
end
