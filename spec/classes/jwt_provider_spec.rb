require 'rails_helper'

RSpec.describe JwtProvider do
  let(:test_payload) { { user_id: 1 } }
  let(:jwt_token) { JwtProvider.encode(test_payload) }

  describe '.encode' do
    it 'encodes a payload and return a string token' do
      expect(jwt_token).to be_a(String)
      expect(jwt_token).to include('.')
    end
  end

  describe '.decode' do
    it 'decodes a token and return the encoded payload' do
      payload = JwtProvider.decode(jwt_token)
      expect(payload).to be_a(Hash)
      expect(payload).to include('user_id')
    end
  end
end
