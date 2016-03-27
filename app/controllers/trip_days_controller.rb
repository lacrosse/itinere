class TripDaysController < ApplicationController
  before_action :authenticate_user_or_guest
  before_action :set_trip_plan
  before_action :set_trip_day, only: [:edit, :update, :destroy]

  def new
    @trip_day = @trip_days.new
  end

  def edit
  end

  def create
    @trip_day = @trip_days.new(trip_day_params)

    if @trip_day.save
      redirect_to trip_plan_path(@trip_plan), notice: 'Congratulations! Your itinerary was successfully updated.'
    else
      render 'new'
    end
  end

  def update
    if @trip_day.update(trip_day_params)
      redirect_to trip_plan_path(@trip_plan), notice: 'Congratulations! Your itinerary was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @trip_day.destroy

    redirect_to trip_plan_path(@trip_plan), notice: 'Congratulations! Your itinerary was successfully updated.'
  end

  private

  def set_trip_plan
    @trip_plan = current_user_or_guest.trip_plans.find(params[:trip_plan_id])
    @trip_days = @trip_plan.trip_days
  end

  def set_trip_day
    @trip_day = @trip_days.find(params[:id])
  end

  def trip_day_params
    params.require(:trip_day).permit(
      *%i(
        date planned_start planned_finish water_availability hammock_trees
        fishing geocaches
      )
    )
  end
end
