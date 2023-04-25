require 'rails_helper'

describe WeatherService do
  context 'instance methods' do
    describe '#get_weather', :vcr do
      it 'returns the weather for a location' do
        weather = File.read('spec/fixtures/weather.json')
        api_key = ENV['WEATHER_API_KEY']
        lat = 39.74001
        lon = -104.99202
        
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
