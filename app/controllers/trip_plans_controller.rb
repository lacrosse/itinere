class TripPlansController < ApplicationController
  before_action :authenticate_user_or_guest

  before_action :set_trip_plans
  before_action :set_trip_plan, only: [:show, :edit, :update, :destroy]

  def index
    @trip_plans = @trip_plans.order('updated_at desc')
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "itinere_trip_plan_#{@trip_plan.id}", formats: [:html]
      end
    end
  end

  def new
    @trip_plan = @trip_plans.new
  end

  def edit
  end

  def create
    @trip_plan = @trip_plans.new(trip_plan_params)

    if @trip_plan.save
      redirect_to trip_plan_path(@trip_plan), notice: 'Congratulations! Your trip plan was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @trip_plan.update(trip_plan_params)
      redirect_to trip_plan_path(@trip_plan), notice: 'Congratulations! Your trip plan was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def set_trip_plans
    @trip_plans = current_user_or_guest.trip_plans
  end

  def set_trip_plan
    @trip_plan = @trip_plans.find(params[:id])
  end

  def trip_plan_params
    params.require(:trip_plan).permit(
      *%i(
        title published unit

        start_location start_location_description
        finish_location finish_location_description

        who_is_going contacts planned_route_url transportation
        expected_departure expected_return freak_out_time communications
        inreach_map local_contact managing_agency

        big_picture_planning
      )
    )
  end
end
