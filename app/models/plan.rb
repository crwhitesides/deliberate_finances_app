class Plan < ActiveRecord::Base
  has_many :user_plans
  has_many :users, through: :user_plans
  has_many :purchases

  def income_available
    total_purchases = Purchase.where(plan_id: self.id).sum(:price)
    self.income - total_purchases
  end
end
