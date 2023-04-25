require 'rails_helper'

describe 'SalaryService' do
	context 'instance methods' do
		describe '#get_salary', :vcr do
			it 'returns the destination city, weather, and salary info for jobs' do
				destination = "chicago"
				chicago_salaries = File.read('spec/fixtures/salaries.json')
				
				salaries = SalaryService.new.get_salaries(destination)

				expect(salaries.keys).to include(:_links, :salaries)

			end
		end
	end
end