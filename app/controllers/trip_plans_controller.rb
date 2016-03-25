class TripPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip_plans

  def index
  end

  def show
    @trip_plan = @trip_plans.find(params[:id])
  end

  def new
  end

  private

  def set_trip_plans
    @trip_plans = current_user.trip_plans
  end
end
