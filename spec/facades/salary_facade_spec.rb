require 'rails_helper'

RSpec.describe SalaryFacade do
	describe 'class methods' do
		describe '#get_salaries' do
			it 'returns the destination city, weather, and salary info for jobs' do
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
				expect(salaries.first.keys).to include(:job, :salary_percentiles)
			end
		end
	end
end