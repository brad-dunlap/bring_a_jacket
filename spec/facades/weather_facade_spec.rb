require 'rails_helper'

RSpec.describe WeatherFacade do
  describe 'class methods' do
    describe '#get_weather' do
      let(:weather) { File.read('spec/fixtures/weather.json') }
      let(:location) { File.read('spec/fixtures/location.json') }
      let(:weather_api_key) { ENV['WEATHER_API_KEY'] }
      let(:location_api_key) { ENV['MAPQUEST_API_KEY'] }

      before do
        allow(LocationService).to receive(:new).and_return(double(get_location: JSON.parse(location)))
      end

      it 'returns a forecast object' do
        stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{weather_api_key}&q=39.74001,-104.99202").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.7.4'
            }
          ).to_return(status: 200, body: weather, headers: {})

        forecast = WeatherFacade.get_weather('denver,co')

        expect(forecast).to be_a(Forecast)
        expect(forecast.current_weather[:temperature]).to eq(23.4)
        expect(forecast.current_weather[:feels_like]).to eq(17.2)
        expect(forecast.current_weather[:humidity]).to eq(86)
        expect(forecast.current_weather[:uvi]).to eq(nil)
        expect(forecast.current_weather[:visibility]).to eq(1.0)
        expect(forecast.current_weather[:condition]).to eq("Patchy light snow")
        expect(forecast.current_weather[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/323.png")
        expect(forecast.daily_weather.count).to eq(5)
        expect(forecast.daily_weather.first[:max_temp]).to eq(43.2)
        expect(forecast.daily_weather.first[:min_temp]).to eq(29.1)
        expect(forecast.daily_weather.first[:condition]).to eq("Moderate rain")
        expect(forecast.daily_weather.first[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/302.png")
        expect(forecast.hourly_weather.count).to eq(24)
        expect(forecast.hourly_weather.first[:temperature]).to eq(32.9)
        expect(forecast.hourly_weather.first[:conditions]).to eq("Heavy snow")
        expect(forecast.hourly_weather.first[:icon]).to eq("//cdn.weatherapi.com/weather/64x64/night/338.png")
      end

			it 'does not return unwanted data' do
				stub_request(:get, "http://api.weatherapi.com/v1/forecast.json?days=5&key=#{weather_api_key}&q=39.74001,-104.99202").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Faraday v2.7.4'
            }
          ).to_return(status: 200, body: weather, headers: {})

        forecast = WeatherFacade.get_weather('denver,co')
				expect(forecast.current_weather).to_not have_key(:temp_c)
				expect(forecast.current_weather[:temperature]).to_not eq(-4.8)
				expect(forecast.current_weather).to_not have_key(:wind_mph)
				expect(forecast.current_weather).to_not have_key(:temp_c)
				expect(forecast.current_weather).to_not have_key(:cloud)
				expect(forecast.daily_weather.first).to_not have_key(:maxtemp_c)
				expect(forecast.daily_weather.first[:max_temp]).to_not eq(6.2)
        expect(forecast.daily_weather.first[:min_temp]).to_not eq(-1.6)
				expect(forecast.hourly_weather.first[:temperature]).to_not eq(0.5)
				expect(forecast.hourly_weather.first[:conditions]).to_not eq("Light snow")
			end
    end
  end
end
