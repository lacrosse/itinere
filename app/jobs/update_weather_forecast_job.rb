require_dependency 'forecast_io'

class UpdateWeatherForecastJob < ActiveJob::Base
  queue_as :normal

  def perform(trip_day_id)
    trip_day = TripDay.find(trip_day_id)
    trip_plan = trip_day.trip_plan

    if (match_data = trip_plan.start_location&.match(/\A(-?\d+(?:\.\d+)?),\s*(-?\d+(?:\.\d+)?)\z/))
      lat, lon = match_data[1..2]

      time = "#{trip_day.date}T00:00:00"

      weather_days = ForecastIo.request(lat, lon, time)

      trip_plan.trip_days.find_each do |day|
        next unless (weather_day = weather_days.find { |wday| wday['date'] == day['date'] })

        day.update_columns(
          daylight: "Sunrise #{weather_day['sunrise']} Sunset #{weather_day['sunset']}",
          moonlight: weather_day['moon_phase'],
          weather: <<~EOF
            #{weather_day['summary']}
            High #{weather_day['max_temperature']} Low #{weather_day['min_temperature']}
            #{weather_day['wind']}
          EOF
        )
      end
    end
  end
end
