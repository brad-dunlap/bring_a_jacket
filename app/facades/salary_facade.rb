
class SalaryFacade
	def self.get_salaries(destination)
		salaries = SalaryService.new.get_salaries(destination)
		require 'pry'; binding.pry
	end
end