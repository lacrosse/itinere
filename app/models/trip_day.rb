class TripDay < ActiveRecord::Base
  belongs_to :trip_plan

  validates :date, presence: true

  after_save :populate_weather

  def title
    "#{trip_plan.title} — #{date_was.strftime('%b %e')}"
  end

  def populate_weather
    UpdateWeatherForecastJob.perform_now(id)
  end
end
