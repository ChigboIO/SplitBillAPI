require 'rails_helper'

RSpec.describe 'Login request', type: :request do
  let(:user_params) { attributes_for(:user) }

  context 'with invalid credentials' do
    it 'return 400 status code' do
      post api_auth_login_path, params: user_params

      expect(response).to have_http_status(400)
    end

    it 'returns with authentication error' do
      post api_auth_login_path, params: user_params

      expect(response.body).to include 'Incorrect username or password'
    end
  end

  context 'with valid credentials' do
    before(:each) { create(:user, user_params) }

    it 'returns a 201 status code' do
      post api_auth_login_path, params: user_params

      expect(response).to have_http_status(201)
    end

    it 'return "Login successful" message' do
      post api_auth_login_path, params: user_params

      expect(response.body).to include 'Login successful'
    end

    it 'contains "token" in the response' do
      post api_auth_login_path, params: user_params

      expect(response.body).to include 'token'
    end

    it 'creates a new Token object upon login' do
      expect { post api_auth_login_path, params: user_params }.to change(Token, :count).by 1
    end
  end
end
