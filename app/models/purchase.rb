class Purchase < ActiveRecord::Base
  belongs_to :plan
  has_many :payments
  has_many :comments

  has_many :purchase_tags
  has_many :tags, through: :purchase_tags

  validates :item, presence: true, length: { maximum: 50 }
  validates :price, presence: true
end
