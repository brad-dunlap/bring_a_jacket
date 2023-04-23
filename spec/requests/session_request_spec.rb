require 'rails_helper'

describe 'Sessions API' do
  describe "POST Api/v0/sessions" do
    let(:create_user_params) do
      {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password"
      }
    end

    before(:each) do
      User.destroy_all
      post "/api/v0/users", params: create_user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

      expect(response.status).to eq(201)
    end

    context "with valid params" do
      let(:login_user_params) do
        {
          email: "whatever@example.com",
          password: "password"
        }
      end

      it "logs in a user" do
        
				post "/api/v0/sessions", params: login_user_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      let(:wrong_email) do 
        {
          email: "wrong@password.com",
          password: "password"
        }
      end

      let(:wrong_password) do
        {
          email: "whatever@example.com",
          password: "wrongpassword"
        }
      end

      it "throws an error if no email found" do
        post "/api/v0/sessions", params: wrong_email.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }

        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to include('errors' => 'Invalid credentials')
      end

      it "throws an error if wrong password" do
        post "/api/v0/sessions", params: wrong_password.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
				
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to include('errors' => 'Invalid credentials')
      end
    end
  end
end
