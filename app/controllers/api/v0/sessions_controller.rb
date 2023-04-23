class Api::V0::SessionsController < ApplicationController
	def create 
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			render json: UsersSerializer.new(user), status: 200
		else
			render json: { errors: 'Invalid credentials' }, status: 400
		end
	end
end