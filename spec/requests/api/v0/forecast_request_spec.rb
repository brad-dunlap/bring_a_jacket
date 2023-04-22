require 'rails_helper'

describe 'Forecast API' do
	describe 'GET /api/v1/forecast' do
		it 'returns the weather for a location' do
			location = "denver,co"
			location_data = File.read('spec/fixtures/location.json')
			map_api_key = ENV['MAPQUEST_API_KEY']
			weather_api_key = ENV['WEATHER_API_KEY']
			weather = File.read('spec/fixtures/weather.json')

			stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{weather_api_key}&q=39.74001,-104.99202").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: weather, headers: {})

        stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=#{map_api_key}&location=denver,co").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.7.4'
            }
          ).
          to_return(status: 200, body: location_data, headers: {})


			get "/api/v0/forecast?location=#{location}"

			expect(response).to be_successful

		end
	end
end