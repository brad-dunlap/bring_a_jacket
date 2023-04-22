require 'rails_helper'

describe LocationService do
  context 'instance methods' do
    describe '#get_location' do 
      it 'returns the lat and long of a location' do
        location = File.read('spec/fixtures/location.json')

        stub_request(:get, "https://www.mapquestapi.com/geocoding/v1/address?key=8G2DN7yCU8Cx4dlEVID16efZOc8jwIJJ&location=denver,co").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.7.4'
            }
          ).
          to_return(status: 200, body: location, headers: {})

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
