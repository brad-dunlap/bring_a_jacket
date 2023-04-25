require 'rails_helper'

describe 'RoadTrip Api' do
	describe 'POST /api/v0/road_trip', :vcr do
		User.destroy_all
		let(:user) { create(:user) }

		let(:request) do
			{
				"origin": "Cincinatti,OH",
				"destination": "Chicago,IL",
				"api_key": user.api_key
			}
		end

		let(:bad_request) do
			{
				"origin": "Cincinatti,OH",
				"destination": "London,UK",
				"api_key": user.api_key
			}
		end

		let(:no_api_key) do
			{
				"origin": "Cincinatti,OH",
				"destination": "Chicago,IL",
				"api_key": "abc123def456"
			}
		end

		it 'returns the road trip information if valid params' do
			post "/api/v0/road_trip", params: request.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
			expect(response.status).to eq(200)

			results = JSON.parse(response.body, symbolize_names: true)
			expect(results).to be_a(Hash)
			expect(results[:data].keys).to include(:id, :type, :attributes)
			expect(results[:data][:attributes].keys).to include(:start_city, :end_city, :travel_time, :weather_at_eta)
		end

		it 'returns the road trip information if invalid travel params' do
			post "/api/v0/road_trip", params: bad_request.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
			expect(response.status).to eq(200)

			results = JSON.parse(response.body, symbolize_names: true)
			expect(results).to be_a(Hash)
			expect(results[:data].keys).to include(:id, :type, :attributes)
			expect(results[:data][:attributes].keys).to include(:start_city, :end_city, :travel_time, :weather_at_eta)
			expect(results[:data][:attributes][:travel_time]).to eq("impossible")
			expect(results[:data][:attributes][:weather_at_eta]).to eq({})
		end

		it 'returns the road trip information if no valid user params' do
			post "/api/v0/road_trip", params: no_api_key.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
			expect(response.status).to eq(401)

			results = JSON.parse(response.body, symbolize_names: true)
			expect(results[:error]).to eq("Unauthorized")
		end
	end
end