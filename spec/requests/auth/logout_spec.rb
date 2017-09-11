require 'rails_helper'

RSpec.describe 'Logout request', type: :request do
  context 'with out the Authorization header' do
    it 'return 401 status code' do
      delete api_auth_logout_path

      expect(response).to have_http_status(401)
    end

    it 'return "Unauthorized access" response' do
      delete api_auth_logout_path

      expect(response.body).to include 'Unauthorized access'
    end
  end

  context 'when valid token is included in the header' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) { user.tokens.create(value: token) }

    it 'return 200 status code' do
      delete api_auth_logout_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

      expect(response).to have_http_status(200)
    end

    it 'return "You are now logged out" response' do
      delete api_auth_logout_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

      expect(response.body).to include 'You are now logged out'
    end

    it 'deletes an entry in the Token model' do
      expect do
        delete api_auth_logout_path, params: {}, headers: { HTTP_AUTHORIZATION: token }
      end.to change(Token, :count).by -1
    end
  end
end
