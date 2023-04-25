class Api::V0::SalariesController < ApplicationController
	
	def index
		destination = params[:destination]
		salary = SalaryFacade.salary_info(destination)
		render json: SalarySerializer.new(salary)
	end
end