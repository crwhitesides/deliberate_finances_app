class Plan < ActiveRecord::Base
  has_many :user_plans
  has_many :users, through: :user_plans
  has_many :purchases

  def money_left_over
    self.purchases_paid_for.sum(&:money_available)
  end

  def income_available
    total_purchases = Purchase.where(plan_id: self.id).sum(:price)
    self.income - total_purchases + money_left_over
  end

  def purchases_pending
    self.purchases.map do |purchase|
      if purchase.money_available > 0
        purchase unless purchase.paid_for? # In other words, a payment's purchase_complete attribute is set to true.
      end
    end.compact
  end

  def purchases_paid_for
    self.purchases.map do |purchase|
      if purchase.paid_for?
        purchase
      end
    end.compact
  end
end
