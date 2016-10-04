class AddPurchaseCompleteToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :purchase_complete, :boolean, default: false
  end
end
