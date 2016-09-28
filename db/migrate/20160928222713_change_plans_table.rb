class ChangePlansTable < ActiveRecord::Migration
  def change
    change_table :plans do |t|
      t.remove :income
      t.decimal :income, default: 0
    end
  end
end
