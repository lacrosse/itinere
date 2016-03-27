class AddUnitToTripPlan < ActiveRecord::Migration
  def change
    add_column :trip_plans, :unit, :integer, default: 0, null: false
  end
end
