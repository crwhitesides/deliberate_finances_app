class PlanSerializer < ActiveModel::Serializer
  attributes :id, :date, :income
  has_many :purchases
  has_many :users
end
