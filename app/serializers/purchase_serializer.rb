class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :item, :price
  has_one :plan
end
