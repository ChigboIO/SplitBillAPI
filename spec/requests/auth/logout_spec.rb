require 'rails_helper'

RSpec.describe 'Logout request', type: :request do
  context 'with out the Authorization header' do
    before(:each) { delete api_auth_logout_path }

    it 'return 401 status code' do
      expect(response).to have_http_status(401)
    end

    it 'return "Unauthorized access" response' do
      expect(response.body).to include 'Unauthorized access'
    end
  end

  context 'when valid token is included in the header' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) do
      user.tokens.create(value: token)
      delete api_auth_logout_path, params: {}, headers: { HTTP_AUTHORIZATION: token }
    end

    it 'return 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'return "You are now logged out" response' do
      expect(response.body).to include 'You are now logged out'
    end
  end
end
