class CreateTripDays < ActiveRecord::Migration
  def change
    create_table :trip_days do |t|
      t.belongs_to :trip_plan
      t.date :date
      t.string :planned_start
      t.string :planned_finish
      t.string :daylight
      t.string :moonlight
      t.string :water_availability
      t.string :hammock_trees
      t.string :fishing
      t.string :weather
      t.string :geocaches
    end
  end
end
