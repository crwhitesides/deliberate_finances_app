class RemovePermissionFromUserPlans < ActiveRecord::Migration
  def change
    remove_column :user_plans, :permission, :string
  end
end
