class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :cost
      t.string :store
      t.integer :purchase_id

      t.timestamps null: false
    end
  end
end
