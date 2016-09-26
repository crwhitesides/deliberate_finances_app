class AddMonthToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :month, :string
  end
end
