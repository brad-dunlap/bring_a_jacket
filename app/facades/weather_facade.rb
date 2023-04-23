# app/facades/weather_facade.rb

class WeatherFacade
  def self.get_weather(location)
    latlong = LocationService.new.get_location(location).deep_symbolize_keys
    lat = latlong[:results][0][:locations][0][:latLng][:lat]
    long = latlong[:results][0][:locations][0][:latLng][:lng]
    weather_data = WeatherService.new.get_weather(lat, long)

		current_weather = {
      last_updated: weather_data[:current][:last_updated],
      temperature: weather_data[:current][:temp_f],
      feels_like: weather_data[:current][:feelslike_f],
      humidity: weather_data[:current][:humidity],
      uvi: weather_data[:current][:uvi],
      visibility: weather_data[:current][:vis_miles],
      condition: weather_data[:current][:condition][:text],
      icon: weather_data[:current][:condition][:icon]
    }

    daily_weather = weather_data[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end

    hourly_weather = weather_data[:forecast][:forecastday].first[:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
		
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end
end
