class CreatePurchaseTags < ActiveRecord::Migration
  def change
    create_table :purchase_tags do |t|
      t.integer :purchase_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
