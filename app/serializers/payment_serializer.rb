class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :amount, :store, :created_at
  has_one :user
end
