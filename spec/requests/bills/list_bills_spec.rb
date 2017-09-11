require 'rails_helper'

RSpec.describe 'List bill request', type: :request do
  context 'with valid auth token' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) { user.tokens.create(value: token) }

    it 'has 200 response code' do
      get api_bills_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

      expect(response).to have_http_status 200
    end

    context 'when user created 2 bills' do
      before(:each) { create_list(:bill, 2, creator: user) }

      it 'returns 2 bills in the json response' do
        get api_bills_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(parsed_body.count).to eql 2
      end

      it 'returns json response that match "bills" schema' do
        get api_bills_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to match_response_schema('bills')
      end
    end

    context 'when you creats 2 bills and is tagged in 2' do
      before(:each) do
        create_list(:bill, 2, creator: user)
        create_list(:bill, 2, splitters: [user.username, 'another_abitrary_user'])
      end

      it 'returns 4 bills in the json response' do
        get api_bills_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(parsed_body.count).to eql 4
      end

      it 'returns json response that match "bills" schema' do
        get api_bills_path, params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to match_response_schema('bills')
      end
    end
  end
end
