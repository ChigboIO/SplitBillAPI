require 'rails_helper'

RSpec.describe 'Show single bill request', type: :request do
  context 'with valid auth token' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) { user.tokens.create(value: token) }

    context 'when bill is NOT found' do
      it 'returns 404 status code' do
        get api_bill_path(1), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to have_http_status 404
      end

      it 'returns NOT found error message' do
        get api_bill_path(1), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response.body).to include 'Bill with given ID not found'
      end
    end

    context 'when requested bill exists' do
      before(:each) { @bill = create(:bill, creator: user) }

      it 'returns 200 status code' do
        get api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to have_http_status 200
      end

      it 'contains the bill title in response body' do
        get api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response.body).to include @bill.title
      end

      it 'returns a response that match the bill schema' do
        get api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to match_response_schema('bill')
      end
    end
  end
end
