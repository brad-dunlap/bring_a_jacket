require 'rails_helper'

RSpec.describe RoadtripFacade do
	describe 'class methods' do
		describe '#get_directions' do
			it 'returns directions for a roadtrip' do
				origin = "New York, NY"
				destination = "Los Angeles, CA"
				api_key = ENV['MAPQUEST_API_KEY']

				roadtrip = File.read('spec/fixtures/roadtrip.json')

				stub_request(:get, "https://www.mapquestapi.com/directions/v2/route?ambiguities=ignore&avoidTimedConditions=false&doReverseGeocode=false&enhancedNarrative=false&from=New%20York,%20NY&key=#{api_key}&outFormat=json&routeType=fastest&to=Los%20Angeles,%20CA").
         with(
           headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.7.4'
           }).
         to_return(status: 200, body: roadtrip, headers: {})

				trip = RoadtripFacade.get_directions(origin, destination)

				expect(trip).to be_a(Hash)
				expect(trip).to have_key(:route)
				expect(trip[:route]).to have_key(:formattedTime)
			end
		end
	end
end