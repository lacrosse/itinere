class AddAlternateIdToTripPlans < ActiveRecord::Migration
  def change
    add_column :trip_plans, :alternate_id, :string

    TripPlan.reset_column_information

    TripPlan.where(alternate_id: nil).find_each do |tp|
      tp.generate_alternate_id
      tp.save
    end

    change_column_null :trip_plans, :alternate_id, false
    add_index :trip_plans, :alternate_id
  end
end
