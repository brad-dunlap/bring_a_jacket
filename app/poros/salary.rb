class Salary
	attr_accessor :id, :destination, :forecast, :salaries

	def initialize(data)
		@id = data[:id]
		@destination = data[:destination]
		@forecast = data[:forecast]
		@salaries = data[:salaries]
	end
end