class Salary

	def initialize(data)
		@id = data[:id]
		@destination = data[:destination]
		@forecast = data[:forecast]
		@salaries = data[:salaries]
	end
end