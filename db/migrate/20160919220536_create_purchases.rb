class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :item
      t.integer :cost
      t.text :note
      t.integer :plan_id

      t.timestamps null: false
    end
  end
end
