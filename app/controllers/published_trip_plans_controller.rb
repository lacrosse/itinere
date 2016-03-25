class PublishedTripPlansController < ApplicationController
  def show
    @trip_plan = TripPlan.published.find_by!(alternate_id: params[:id])
  end
end
