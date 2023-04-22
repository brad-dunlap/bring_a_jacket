require 'rails_helper'

RSpec.describe Forecast do
	describe '#initialize' do
		context ' when given valid attributes' do
			it 'creates a forecast object' do
				current_weather = {
					:last_updated=>"2023-04-22 09:30",
					:temperature=>23.4,
					:feels_like=>17.2,
					:humidity=>86,
					:uvi=>nil,
					:visibility=>1.0,
					:condition=>"Patchy light snow",
					:icon=>"//cdn.weatherapi.com/weather/64x64/day/323.png"
				}

				daily_weather = [
					{
						:date=>"2023-04-22",
						:sunrise=>"06:12 AM",
						:sunset=>"07:45 PM",
						:max_temp=>43.2,
						:min_temp=>29.1,
						:condition=>"Moderate rain",
						:icon=>"//cdn.weatherapi.com/weather/64x64/day/302.png"},
			 		{
						:date=>"2023-04-23",
						:sunrise=>"06:11 AM",
						:sunset=>"07:46 PM",
						:max_temp=>59.7,
						:min_temp=>33.8,
						:condition=>"Sunny",
						:icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
			 		{
						:date=>"2023-04-24",
						:sunrise=>"06:10 AM",
						:sunset=>"07:47 PM",
						:max_temp=>63.9,
						:min_temp=>42.1,
						:condition=>"Patchy rain possible",
						:icon=>"//cdn.weatherapi.com/weather/64x64/day/176.png"},
			 		{
						:date=>"2023-04-25",
						:sunrise=>"06:08 AM",
						:sunset=>"07:48 PM",
						:max_temp=>55.2,
						:min_temp=>39.7,
						:condition=>"Heavy rain",
						:icon=>"//cdn.weatherapi.com/weather/64x64/day/308.png"},
			 		{
						:date=>"2023-04-26",
						:sunrise=>"06:07 AM",
						:sunset=>"07:49 PM",
						:max_temp=>41.2,
						:min_temp=>34.5,
						:condition=>"Moderate rain",
						:icon=>"//cdn.weatherapi.com/weather/64x64/day/302.png"
						}
					]

					hourly_weather = [
						{:time=>"2023-04-22 00:00", :temperature=>32.9, :conditions=>"Heavy snow", :icon=>"//cdn.weatherapi.com/weather/64x64/night/338.png"},
						{:time=>"2023-04-22 01:00", :temperature=>32.2, :conditions=>"Heavy snow", :icon=>"//cdn.weatherapi.com/weather/64x64/night/338.png"},
						{:time=>"2023-04-22 02:00", :temperature=>31.8, :conditions=>"Heavy snow", :icon=>"//cdn.weatherapi.com/weather/64x64/night/338.png"},
						{:time=>"2023-04-22 03:00", :temperature=>30.7, :conditions=>"Heavy snow", :icon=>"//cdn.weatherapi.com/weather/64x64/night/338.png"},
						{:time=>"2023-04-22 04:00", :temperature=>30.7, :conditions=>"Overcast", :icon=>"//cdn.weatherapi.com/weather/64x64/night/122.png"},
						{:time=>"2023-04-22 05:00", :temperature=>30.4, :conditions=>"Moderate or heavy snow showers", :icon=>"//cdn.weatherapi.com/weather/64x64/night/371.png"},
						{:time=>"2023-04-22 06:00", :temperature=>29.5, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/116.png"},
						{:time=>"2023-04-22 07:00", :temperature=>29.1, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 08:00", :temperature=>29.3, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 09:00", :temperature=>30.2, :conditions=>"Patchy moderate snow", :icon=>"//cdn.weatherapi.com/weather/64x64/day/329.png"},
						{:time=>"2023-04-22 10:00", :temperature=>32.0, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
						{:time=>"2023-04-22 11:00", :temperature=>34.9, :conditions=>"Patchy snow possible", :icon=>"//cdn.weatherapi.com/weather/64x64/day/179.png"},
						{:time=>"2023-04-22 12:00", :temperature=>37.6, :conditions=>"Sunny", :icon=>"//cdn.weatherapi.com/weather/64x64/day/113.png"},
						{:time=>"2023-04-22 13:00", :temperature=>40.1, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 14:00", :temperature=>41.0, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 15:00", :temperature=>41.2, :conditions=>"Light sleet", :icon=>"//cdn.weatherapi.com/weather/64x64/day/317.png"},
						{:time=>"2023-04-22 16:00", :temperature=>41.7, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 17:00", :temperature=>42.8, :conditions=>"Patchy rain possible", :icon=>"//cdn.weatherapi.com/weather/64x64/day/176.png"},
						{:time=>"2023-04-22 18:00", :temperature=>43.2, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 19:00", :temperature=>42.6, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/day/116.png"},
						{:time=>"2023-04-22 20:00", :temperature=>40.3, :conditions=>"Partly cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/116.png"},
						{:time=>"2023-04-22 21:00", :temperature=>39.2, :conditions=>"Patchy sleet possible", :icon=>"//cdn.weatherapi.com/weather/64x64/night/182.png"},
						{:time=>"2023-04-22 22:00", :temperature=>38.3, :conditions=>"Cloudy", :icon=>"//cdn.weatherapi.com/weather/64x64/night/119.png"},
						{:time=>"2023-04-22 23:00", :temperature=>37.4, :conditions=>"Moderate or heavy snow showers", :icon=>"//cdn.weatherapi.com/weather/64x64/night/371.png"}
					]

				forecast = Forecast.new(current_weather, daily_weather, hourly_weather)
				expect(forecast).to be_a(Forecast)
				expect(forecast.id).to eq("null")
				expect(forecast.type).to eq("forecast")
				expect(forecast.current_weather).to eq(current_weather)
				expect(forecast.daily_weather).to eq(daily_weather)
				expect(forecast.hourly_weather).to eq(hourly_weather)
			end
		end
	end
end