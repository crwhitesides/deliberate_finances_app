class AddMonthToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :date, :date
  end
end
