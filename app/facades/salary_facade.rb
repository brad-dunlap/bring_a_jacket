
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
					min: sprintf("$%.2f", min),
					max: sprintf("$%.2f", max)
				}
			end
		end
		jobs
	end
end