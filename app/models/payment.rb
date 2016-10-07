class Payment < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :user

  default_scope { order(created_at: :desc) }
  validates :amount, presence: true
  validates :store, presence: true, length: { maximum: 50 }

  def self.filter_payments(userid)
    where('user_id = ?', userid)
  end
end
