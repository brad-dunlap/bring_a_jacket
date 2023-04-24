require 'rails_helper'

RSpec.describe Salary do
  describe '#initialize' do
    context 'when given valid attributes' do
      let(:info) do
        {
          id: "null",
          destination: "chicago",
          forecast: {
            summary: "ALL THE SUNSHINE",
            temperature: "77.7"
          },
          salaries: [
            {
              title: "Data Analyst",
              min: "$46,898.19",
              max: "$67,929.19"
            },
            {
              title: "Data Scientist",
              min: "$71,025.60",
              max: "$103,647.55"
            }
          ]
        }
      end

      it 'creates a salary object' do
        salary = Salary.new(info)
        expect(salary).to be_a(Salary)
        expect(salary.id).to eq "null"
        expect(salary.destination).to eq "chicago"
        expect(salary.forecast).to be_a(Hash)
        expect(salary.forecast[:summary]).to eq "ALL THE SUNSHINE"
        expect(salary.forecast[:temperature]).to eq "77.7"
        expect(salary.salaries).to be_an(Array)
        expect(salary.salaries.count).to eq 2
        expect(salary.salaries.first).to be_a(Hash)
        expect(salary.salaries.first[:title]).to eq "Data Analyst"
        expect(salary.salaries.first[:min]).to eq "$46,898.19"
        expect(salary.salaries.first[:max]).to eq "$67,929.19"
      end
    end
  end
end
