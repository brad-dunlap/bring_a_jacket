require 'rails_helper'

describe 'SalaryService' do
	context 'instance methods' do
		describe '#get_salary' do
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

				salaries = SalaryService.new.get_salaries(destination)

				expect(salaries.keys).to include(:_links, :salaries)

			end
		end
	end
end