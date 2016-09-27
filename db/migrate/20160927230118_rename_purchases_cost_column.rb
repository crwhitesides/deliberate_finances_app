class RenamePurchasesCostColumn < ActiveRecord::Migration
  def change
    change_table :purchases do |t|
      t.rename :cost, :price
    end
  end
end
