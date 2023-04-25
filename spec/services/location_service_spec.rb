require 'rails_helper'

describe LocationService do
  context 'instance methods' do
    describe '#get_location', :vcr do 
      it 'returns the lat and long of a location' do
        location = File.read('spec/fixtures/location.json')
				api_key = ENV['MAPQUEST_API_KEY']

        location_data = LocationService.new.get_location('denver,co')

        expect(location_data).to be_a(Hash)
        expect(location_data[:results]).to be_a(Array)
        expect(location_data[:results].length).to eq(1)

        result = location_data[:results][0]

        expect(result[:locations]).to be_a(Array)
        expect(result[:locations].length).to eq(1)

        location = result[:locations][0]

        expect(location[:latLng]).to be_a(Hash)
        expect(location[:latLng][:lat]).to be_a(Float)
        expect(location[:latLng][:lat]).to eq(39.74001)
        expect(location[:latLng][:lng]).to be_a(Float)
        expect(location[:latLng][:lng]).to eq(-104.99202)
      end
    end
  end
end
