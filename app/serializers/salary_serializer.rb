class SalarySerializer
  include JSONAPI::Serializer
	set_type :salaries

	attributes :destination, :forecast, :salaries

end