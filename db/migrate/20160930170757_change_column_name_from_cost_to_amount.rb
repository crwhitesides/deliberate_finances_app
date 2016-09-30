class ChangeColumnNameFromCostToAmount < ActiveRecord::Migration
  def change
    change_table :payments do |t|
      t.rename :cost, :amount
    end
  end
end
