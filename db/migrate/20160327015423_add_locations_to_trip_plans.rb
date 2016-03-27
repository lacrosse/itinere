class AddLocationsToTripPlans < ActiveRecord::Migration
  def change
    add_column :trip_plans, :start_location, :string
    add_column :trip_plans, :finish_location, :string
    add_column :trip_plans, :start_location_description, :string
    add_column :trip_plans, :finish_location_description, :string
  end
end
