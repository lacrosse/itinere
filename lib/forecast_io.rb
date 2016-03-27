module ForecastIo
  class << self
    UNITS = {
      us: {
        temperatureMin: 'F',
        temperatureMax: 'F',
        windSpeed: 'mph'
      },
      si: {
        temperatureMin: 'C',
        temperatureMax: 'C',
        windSpeed: 'm/s'
      },
      ca: {
        temperatureMin: 'C',
        temperatureMax: 'C',
        windSpeed: 'km/h'
      },
      uk2: {
        temperatureMin: 'C',
        temperatureMax: 'C',
        windSpeed: 'mph'
      }
    }.with_indifferent_access.freeze

    def request(lat, lon, time = nil)
      query = [lat, lon, time].compact.join(',')

      uri = URI("https://api.forecast.io/forecast/#{Rails.application.secrets.forecastio['key']}/#{query}?units=auto")

      response = Net::HTTP.get(uri)

      weather = JSON.parse(response)

      timezone = weather['timezone']
      units = UNITS[weather['flags']['units']]

      weather['daily']['data'].map do |day_weather|
        wind = "#{day_weather['windSpeed']} #{units['windSpeed']} #{wind_degrees_to_direction(day_weather['windBearing'])}"

        {
          'date' => Time.at(day_weather['time']).in_time_zone(timezone).to_date,
          'sunrise' => Time.at(day_weather['sunriseTime']).in_time_zone(timezone).to_s(:time),
          'sunset' => Time.at(day_weather['sunsetTime']).in_time_zone(timezone).to_s(:time),
          'min_temperature' => "#{day_weather['temperatureMin']}°#{units['temperatureMin']}",
          'max_temperature' => "#{day_weather['temperatureMax']}°#{units['temperatureMax']}",
          'wind' => wind,
          'moon_phase' => lunation_number_to_moon_phase(day_weather['moonPhase'])
        }.merge(day_weather.slice('summary'))
      end
    end

    private

    def lunation_number_to_moon_phase(number)
      case number
      when 0.0 then 'new moon'
      when (0.0...0.25) then 'waxing crescent'
      when (0.25...0.5) then 'waxing gibbous'
      when 0.5 then 'full moon'
      when (0.5...0.75) then 'waning gibbous'
      when (0.75...1) then 'waning crescent'
      end
    end

    def wind_degrees_to_direction(degrees)
      case (degrees / 45.0).round
      when 0, 8 then 'N'
      when 1 then 'NE'
      when 2 then 'E'
      when 3 then 'SE'
      when 4 then 'S'
      when 5 then 'SW'
      when 6 then 'W'
      when 7 then 'NW'
      end
    end
  end
end
