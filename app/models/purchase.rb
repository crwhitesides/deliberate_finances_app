class Purchase < ActiveRecord::Base
  belongs_to :plan
  has_many :payments
  has_many :users, through: :payments

  has_many :purchase_tags
  has_many :tags, through: :purchase_tags

  validates :item, presence: true, length: { maximum: 50 }
  validates :price, presence: true

  accepts_nested_attributes_for :tags

  def total_payments
    Payment.where(purchase_id: self.id).sum(:amount)
  end

  def money_available
    self.price - total_payments
  end

  def paid_for?
    self.money_available <= 0 || self.payments.where(purchase_complete: true).count > 0
  end
end
