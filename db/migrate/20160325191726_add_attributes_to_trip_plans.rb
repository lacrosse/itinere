class AddAttributesToTripPlans < ActiveRecord::Migration
  def change
    change_table :trip_plans do |t|
      t.string :who_is_going
      t.string :contacts
      t.string :transportation
      t.string :expected_departure
      t.string :expected_return
      t.string :freak_out_time
      t.string :communications
      t.string :inreach_map
      t.string :local_contact
      t.string :managing_agency
    end
  end
end
