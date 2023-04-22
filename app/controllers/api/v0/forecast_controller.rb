class Api::V0::ForecastController < ApplicationController
	
	def index
		location = params[:location]
		weather = WeatherFacade.get_weather(location)
		render json: ForecastSerializer.new(weather)
	end
end