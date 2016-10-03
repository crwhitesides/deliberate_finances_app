class Plan < ActiveRecord::Base
  has_many :user_plans
  has_many :users, through: :user_plans
  has_many :purchases

  def income_available
    total_purchases = Purchase.where(plan_id: self.id).sum(:price)
    self.income - total_purchases
  end

  def purchases_with_a_budget
    self.purchases.map do |purchase|
      if purchase.money_available > 0
        purchase
      end
    end.compact
  end

  def purchases_paid_for
    self.purchases.map do |purchase|
      if purchase.money_available <= 0
        purchase
      end
    end.compact
  end
end
