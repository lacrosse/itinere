class CreateTripPlans < ActiveRecord::Migration
  def change
    create_table :trip_plans do |t|
      t.belongs_to :user

      t.string :title, null: false
      t.string :planned_route_url
    end
  end
end
