class PurchaseTag < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :tag
end
