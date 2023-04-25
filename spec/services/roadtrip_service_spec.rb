require 'rails_helper'

describe 'RoadtripService' do
  context 'instance methods', :vcr do
    describe '#get_directions' do
      it 'returns directions for a roadtrip' do
        origin = "New York, NY"
        destination = "Los Angeles, CA"
        api_key = ENV['MAPQUEST_API_KEY']

				roadtrip = File.read('spec/fixtures/roadtrip.json')

        roadtrip = RoadtripService.new.get_directions(origin, destination)

        expect(roadtrip).to be_a(Hash)
				expect(roadtrip).to have_key(:route)
				expect(roadtrip[:route]).to have_key(:formattedTime)
      end
    end
  end
end
