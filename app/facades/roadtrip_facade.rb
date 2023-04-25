
class RoadtripFacade
	def self.get_directions(origin, destination)
		roadtrip = RoadtripService.new.get_directions(origin, destination)
		latlong = LocationService.new.get_location(destination).deep_symbolize_keys
		lat = latlong[:results][0][:locations][0][:latLng][:lat]
		long = latlong[:results][0][:locations][0][:latLng][:lng]
		weather_data = WeatherService.new.get_weather(lat, long)
		
		travel_time = roadtrip[:route][:time]
		arrival_time = Time.now + travel_time
		formatted_travel_time = roadtrip[:route][:formattedTime]
	
		weather_data[:forecast][:forecastday].each do |day|
			if arrival_time.to_s.include?(day[:date])
				day[:hour].each do |hour|
					if arrival_time >= Time.parse(hour[:time]) && arrival_time <= Time.parse(hour[:time]) + 1.hour
						data = {
							start_city: origin,
							end_city: destination,
							travel_time: formatted_travel_time,
							weather_at_eta: {
								datetime: hour[:time],
								temperature: hour[:temp_f],
								condition: hour[:condition][:text]
							}
						}
						Roadtrip.new(data)
						return data
					end
				end
			end
		end
	end
end