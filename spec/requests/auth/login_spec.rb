require 'rails_helper'

RSpec.describe 'Login request', type: :request do
  let(:user_params) { attributes_for(:user) }

  context 'with invalid credentials' do
    before(:each) { post api_auth_login_path, params: user_params }

    it 'return 400 status code' do
      expect(response).to have_http_status(400)
    end

    it 'returns with authentication error' do
      expect(response.body).to include 'Incorrect username or password'
    end
  end

  context 'with valid credentials' do
    before(:each) do
      create(:user, user_params)
      post api_auth_login_path, params: user_params
    end

    it 'returns a 201 status code' do
      expect(response).to have_http_status(201)
    end

    it 'return "Login successful" message' do
      expect(response.body).to include 'Login successful'
    end

    it 'contains "token" in the response' do
      expect(response.body).to include 'token'
    end
  end
end
