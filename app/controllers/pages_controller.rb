class PagesController < ApplicationController
  def landing
    return unless user_signed_in?

    redirect_to trip_plans_path
  end
end
