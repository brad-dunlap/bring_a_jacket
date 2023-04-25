
class RoadtripFacade
	def self.get_directions(origin, destination)
		roadtrip = RoadtripService.new.get_directions(origin, destination)
		latlong = LocationService.new.get_location(destination).deep_symbolize_keys
    lat = latlong[:results][0][:locations][0][:latLng][:lat]
    long = latlong[:results][0][:locations][0][:latLng][:lng]
    weather_data = WeatherService.new.get_weather(lat, long)
		
		travel_time = roadtrip[:route][:time]
		arrival_time = Time.now + travel_time
		require 'pry'; binding.pry
	end
end