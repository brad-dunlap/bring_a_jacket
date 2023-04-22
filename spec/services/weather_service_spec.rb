require 'rails_helper'

describe WeatherService do
  context 'instance methods' do
    describe '#get_weather' do
      it 'returns the weather for a location' do
        weather = File.read('spec/fixtures/weather.json')
        api_key = ENV['WEATHER_API_KEY']
        lat = 39.74001
        lon = -104.99202

        stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{lat},#{lon}&days=5")
          .to_return(status: 200, body: weather, headers: {})

        weather_data = WeatherService.new.get_weather(lat, lon)

        expect(weather_data).to be_a(Hash)
        expect(weather_data[:location]).to have_key(:name)
        expect(weather_data[:location][:name]).to eq("Denver")
        expect(weather_data[:current]).to have_key(:temp_c)
        expect(weather_data[:current][:temp_c]).to be_a(Float)
        expect(weather_data[:forecast]).to have_key(:forecastday)
        expect(weather_data[:forecast][:forecastday]).to be_a(Array)
        expect(weather_data[:forecast][:forecastday].length).to eq(5)
      end
    end
  end
end
