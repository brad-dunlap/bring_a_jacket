require 'rails_helper'

RSpec.describe RoadtripFacade do
	describe 'class methods' do
		describe '#get_directions', :vcr do
			it 'returns directions for a roadtrip' do
				origin = "New York, NY"
				destination = "Los Angeles, CA"
				api_key = ENV['MAPQUEST_API_KEY']

				trip = RoadtripFacade.get_directions(origin, destination)
				expect(trip).to be_a(Roadtrip)
				expect(trip.id).to eq("null")
				expect(trip.start_city).to eq('New York, NY')
				expect(trip.end_city).to eq('Los Angeles, CA')
				expect(trip.travel_time).to be_a(String)
				expect(trip.weather_at_eta).to be_a(Hash)
				expect(trip.weather_at_eta[:temperature]).to be_a(Float)
				expect(trip.weather_at_eta[:condition]).to be_a(String)
			end
		end
	end
end