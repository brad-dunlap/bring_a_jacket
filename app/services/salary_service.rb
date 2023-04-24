class SalaryService
	def get_salaries(destination)
		response = conn.get("urban_areas/slug:#{destination}/salaries")
		JSON.parse(response.body, symbolize_names: true)
	end

	private
	
	def conn
		Faraday.new(url: "https://api.teleport.org/api/")
	end
end