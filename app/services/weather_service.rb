class WeatherService
	def get_weather(lat, lon)
		response = conn.get("forecast.json?key=#{ENV['WEATHER_API_KEY']}&q=#{lat},#{lon}&days=5")
		JSON.parse(response.body, symbolize_names: true)
	end

	private

	def conn
		Faraday.new(url: "http://api.weatherapi.com/v1/")
	end
end