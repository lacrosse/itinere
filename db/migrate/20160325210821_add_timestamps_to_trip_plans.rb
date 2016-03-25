class AddTimestampsToTripPlans < ActiveRecord::Migration
  def change
    change_table(:trip_plans, &:timestamps)

    TripPlan.find_each do |tp|
      tp.update created_at: Time.now.utc, updated_at: Time.now.utc
    end

    change_column_null :trip_plans, :created_at, false
    change_column_null :trip_plans, :updated_at, false
  end
end
