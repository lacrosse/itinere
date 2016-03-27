class RemoveUnitFromTripPlans < ActiveRecord::Migration
  def change
    remove_column :trip_plans, :unit
  end
end
