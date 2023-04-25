require 'rails_helper'

RSpec.describe SalaryFacade do
	describe 'class methods', :vcr do
		describe '#get_salaries' do
			it 'returns the destination city salary info for jobs' do
				destination = "chicago"
				chicago_salaries = File.read('spec/fixtures/salaries.json')
				

				salaries = SalaryFacade.get_salaries(destination)
				expect(salaries.count).to eq(7)
				expect(salaries.first.keys).to include(:title, :min, :max)
				expect(salaries.first[:title]).to eq("Data Analyst")
				expect(salaries.first[:min]).to eq("$46,898.19")
				expect(salaries.first[:max]).to eq("$67,929.19")
			end

			it 'returns weather information for destination' do
				destination = 'chicago'
				weather = File.read('spec/fixtures/chicago_weather.json')
				location = File.read('spec/fixtures/chicago_location.json')
				
				
				weather = SalaryFacade.get_weather(destination)
				expect(weather).to be_a(Hash)
			end

			it 'returns salary and weather information for destination' do
			
				destination = "chicago"
				weather = File.read('spec/fixtures/chicago_weather.json')
				salaries = File.read('spec/fixtures/salaries.json')
				location = File.read('spec/fixtures/chicago_location.json')
				
				info = SalaryFacade.salary_info(destination)
			end
		end
	end
end