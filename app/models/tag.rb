class Tag < ActiveRecord::Base
  has_many :purchase_tags
  has_many :purchases, through: :purchase_tags
end
