require 'rails_helper'

describe 'Forecast API' do
	describe 'GET /api/v0/forecast', :vcr do
		it 'returns the weather for a location' do
			location = "denver,co"
			location_data = File.read('spec/fixtures/location.json')
			map_api_key = ENV['MAPQUEST_API_KEY']
			weather_api_key = ENV['WEATHER_API_KEY']
			weather = File.read('spec/fixtures/weather.json')
			
			get "/api/v0/forecast?location=#{location}"

			expect(response).to be_successful

			parsed = JSON.parse(response.body, symbolize_names: true)
			data = parsed[:data][:attributes]

			expect(data.keys).to match_array([:current_weather, :daily_weather, :hourly_weather])
			expect(data[:current_weather].keys).to match_array([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
			expect(data[:daily_weather].first.keys).to match_array([:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon])
			expect(data[:hourly_weather].first.keys).to match_array([:time, :temperature, :conditions, :icon])
	 end
	end
end