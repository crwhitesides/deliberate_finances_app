class Payment < ActiveRecord::Base
  belongs_to :purchase

  validates :amount, presence: true
  validates :store, presence: true, length: { maximum: 50 }
end
