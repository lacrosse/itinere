class AddPublishedToTripPlans < ActiveRecord::Migration
  def change
    add_column :trip_plans, :published, :boolean, default: false

    TripPlan.reset_column_information

    TripPlan.where(published: nil).find_each do |tp|
      tp.update published: false
    end

    change_column_null :trip_plans, :published, false
  end
end
