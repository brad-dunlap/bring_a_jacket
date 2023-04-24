require 'rails_helper'

describe 'Salaries API' do
	describe 'GET /api/v0/salaries' do
		it 'returns the destinations weather and salary information' do
			destination = "chicago"
			salary_info = File.read('spec/fixtures/salaries.json')
			weather_info = File.read('spec/fixtures/chicago_weather.json')
			weather_api_key = ENV['WEATHER_API_KEY']
			location = File.read('spec/fixtures/chicago_location.json')

			stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=8G2DN7yCU8Cx4dlEVID16efZOc8jwIJJ&location=chicago").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: location, headers: {})

				 stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=23f44e62a7b442dfa52145319232204&q=41.88425,-87.63245").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: weather_info, headers: {})

				 stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:chicago/salaries").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: salary_info, headers: {})

			get "/api/v0/salaries?location=#{destination}"
			results = JSON.parse(response.body, symbolize_names: true)
			expect(response).to be_successful
			expect(results.keys).to include(:data)
			expect(results[:data][:id]).to eq("null")
			expect(results[:data][:type]).to eq("salaries")
			expect(results[:data][:attributes].keys).to include(:destination, :forecast, :salaries)
		end
	end
end