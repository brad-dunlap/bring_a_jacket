require 'rails_helper'

RSpec.describe SalaryFacade do
	describe 'class methods' do
		describe '#get_salaries' do
			it 'returns the destination city salary info for jobs' do
				destination = "chicago"
				chicago_salaries = File.read('spec/fixtures/salaries.json')

				stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:chicago/salaries").
				with(
					headers: {
				 'Accept'=>'*/*',
				 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
				 'User-Agent'=>'Faraday v2.7.4'
					}).
				to_return(status: 200, body: chicago_salaries, headers: {})

				salaries = SalaryFacade.get_salaries(destination)
				expect(salaries.count).to eq(7)
				expect(salaries.first.keys).to include(:title, :min, :max)
				expect(salaries.first[:title]).to eq("Data Analyst")
				expect(salaries.first[:min]).to eq("$46898.19")
				expect(salaries.first[:max]).to eq("$67929.19")
			end

			it 'returns weather information for destination' do
				destination = 'chicago'
				weather = File.read('spec/fixtures/chicago_weather.json')
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
         to_return(status: 200, body: weather, headers: {})

				weather = SalaryFacade.get_weather(destination)
				expect(weather).to be_a(Hash)
			end

			it 'returns salary and weather information for destination' do
			
				destination = "chicago"
				weather = File.read('spec/fixtures/chicago_weather.json')
				salaries = File.read('spec/fixtures/salaries.json')
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
         to_return(status: 200, body: weather, headers: {})

				 stub_request(:get, "https://api.teleport.org/api/urban_areas/slug:chicago/salaries").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: salaries, headers: {})


				info = SalaryFacade.salary_info(destination)
			end
		end
	end
end