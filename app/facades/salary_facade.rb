
class SalaryFacade
	def self.get_salaries(destination)
		salaries = SalaryService.new.get_salaries(destination)
		
		jobs = []
		job_titles = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]
		
		salaries[:salaries].each do |salary|
			if job_titles.include?(salary[:job][:title])
				min = salary[:salary_percentiles][:percentile_25]
				max = salary[:salary_percentiles][:percentile_75]
				jobs << {
					title:salary[:job][:title],
					min: ActiveSupport::NumberHelper.number_to_currency(min, unit: "$", precision: 2),
        	max: ActiveSupport::NumberHelper.number_to_currency(max, unit: "$", precision: 2)
      }
			end
		end
		jobs
	end

	def self.get_weather(destination)
		latlong = LocationService.new.get_location(destination).deep_symbolize_keys
    lat = latlong[:results][0][:locations][0][:latLng][:lat]
    long = latlong[:results][0][:locations][0][:latLng][:lng]
    weather_data = WeatherService.new.get_weather(lat, long)

		current_weather = {
      summary: weather_data[:current][:condition][:text],
      temperature: "#{weather_data[:current][:temp_f]}°F"
    }
	end

	def self.salary_info(destination)
		results = {
			id: "null",
			destination: destination,
			forecast: get_weather(destination),
			salaries: get_salaries(destination)
		}
		Salary.new(results)
	end
end