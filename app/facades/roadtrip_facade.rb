
class RoadtripFacade
	def self.get_directions(origin, destination)
		roadtrip = RoadtripService.new.get_directions(origin, destination)

		travel_time = roadtrip[:route][:time]
		arrival_time = Time.now + travel_time
	end
end