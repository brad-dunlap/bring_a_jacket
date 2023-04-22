require 'rails_helper'

describe 'Forecast API' do
  describe "POST Api/v0/users" do
    context "with valid params" do
      let(:user_params) do
        {
          email: "whatever@example.com",
          password: "password",
          password_confirmation: "password"
        }
      end

			let(:invalid_params) do
				{
					email: "hi@hi.com",
					password: "password",
					password_confirmation: "passwor"
				}
			end

			let(:missing_params) do
				{
					email: "",
					password: "password",
					password_confirmation: "password"
				}
			end
			
      it "creates a new user and generates an api key" do
				User.destroy_all
				post "/api/v0/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
				expect(response.status).to eq(201)
				expect(JSON.parse(response.body)["data"]["type"]).to eq("users")
				expect(User.count).to eq(1)
				expect(User.first.api_key).not_to be_blank
				expect(JSON.parse(response.body)["data"]["attributes"]["password"]).to be_nil
			end

      it "returns an error if passwords do not match" do
				post "/api/v0/users", params: invalid_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
				expect(response.status).to eq(400)
				expect(JSON.parse(response.body)["errors"][0]).to eq("Password confirmation doesn't match Password")
			end

			it "returns an email if the user already exists" do
				User.destroy_all
				post "/api/v0/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
				expect(response.status).to eq(201)

				post "/api/v0/users", params: user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
				expect(response.status).to eq(400)
				expect(JSON.parse(response.body)["errors"][0]).to eq("Email has already been taken")
			end

			it "returns an error if a param is missing" do
				User.destroy_all
				post "/api/v0/users", params: missing_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
				expect(response.status).to eq(400)
				expect(JSON.parse(response.body)["errors"][0]).to eq("Email can't be blank")
			end
    end
  end
end
