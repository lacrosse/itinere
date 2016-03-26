class AddBigPicturePlanningToTripPlans < ActiveRecord::Migration
  def change
    add_column :trip_plans, :big_picture_planning, :text
  end
end
