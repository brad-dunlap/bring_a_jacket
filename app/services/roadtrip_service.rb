class RoadtripService
	def get_directions(origin, destination)
		response = conn.get("route?key=#{ENV['MAPQUEST_API_KEY']}&from=#{origin}&to=#{destination}&outFormat=json&ambiguities=ignore&routeType=fastest&doReverseGeocode=false&enhancedNarrative=false&avoidTimedConditions=false")
		JSON.parse(response.body, symbolize_names: true)

	end

	private
	
	def conn
		Faraday.new(url: "https://www.mapquestapi.com/directions/v2/")
	end
end