require 'rails_helper'

describe 'Salaries API' do
	describe 'GET /api/v0/salaries' do
		it 'returns the destinations weather and salary information' do
			destination = "chicago"
			salary_info = File.read('spec/fixtures/salaries.json')
			weather_info = File.read('spec/fixtures/chicago_weather.json')
			weather_api_key = ENV['WEATHER_API_KEY']

			get "/api/v0/salaries?location=#{destination}"

			expect(response).to be_successful
		end
	end
end