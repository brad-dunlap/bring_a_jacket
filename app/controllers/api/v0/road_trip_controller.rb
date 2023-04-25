class Api::V0::RoadTripController < ApplicationController

	def create
		@user = User.find_by(api_key: road_trip_params[:api_key])
		if @user
			roadtrip = RoadtripFacade.get_directions(road_trip_params[:origin], road_trip_params[:destination])
			render json: RoadtripSerializer.new(roadtrip)
		end
	end

	private

	def road_trip_params
		params.permit(:id, :origin, :destination, :api_key)
	end
end