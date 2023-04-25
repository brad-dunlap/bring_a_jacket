class Api::V0::RoadTripController < ApplicationController

	def create
		@user = User.find_by(api_key: params[:api_key])
		if @user && @user.api_key == params[:api_key]
			roadtrip = RoadtripFacade.get_directions(params[:origin], params[:destination])
			render json: RoadtripSerializer.new(roadtrip)
		else
			render json: {error: "Unauthorized"}, status: 401
		end
	end
end