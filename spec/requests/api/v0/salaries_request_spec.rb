require 'rails_helper'

describe 'Salaries API' do
	describe 'GET /api/v0/salaries', :vcr do
		it 'returns the destinations weather and salary information' do
			destination = "chicago"
			salary_info = File.read('spec/fixtures/salaries.json')
			weather_info = File.read('spec/fixtures/chicago_weather.json')
			weather_api_key = ENV['WEATHER_API_KEY']
			location = File.read('spec/fixtures/chicago_location.json')

			
			get "/api/v0/salaries?destination=#{destination}"

			results = JSON.parse(response.body, symbolize_names: true)
			expect(response).to be_successful
			expect(results.keys).to include(:data)
			expect(results[:data][:id]).to eq("null")
			expect(results[:data][:type]).to eq("salaries")
			expect(results[:data][:attributes].keys).to include(:destination, :forecast, :salaries)
		end
	end
end