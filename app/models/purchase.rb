class Purchase < ActiveRecord::Base
  belongs_to :plan
  has_many :payments
  has_many :users, through: :payments

  has_many :purchase_tags
  has_many :tags, through: :purchase_tags

  validates :item, presence: true, length: { maximum: 50 }
  validates :price, presence: true

  accepts_nested_attributes_for :tags

  def tags_attributes=(tag_attributes)
    tag_attributes.values.each do |tag_attribute|
      tag = Tag.find_or_create_by(tag_attribute)
      self.tags << tag unless tag == ""
    end
  end
end
