
class SalaryFacade
	def self.get_salaries(destination)
		salaries = SalaryService.new.get_salaries(destination)
		
		jobs = []
		job_titles = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]
		
		salaries[:salaries].each do |salary|
			if job_titles.include?(salary[:job][:title])
				jobs << salary
			end
		end
		jobs
	end
end