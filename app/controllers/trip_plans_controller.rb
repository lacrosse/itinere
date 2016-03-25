class TripPlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @trip_plans = [
      :trip_plan_1,
      :trip_plan_2
    ]
  end
end
