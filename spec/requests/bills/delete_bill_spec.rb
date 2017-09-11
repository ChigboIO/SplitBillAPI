require 'rails_helper'

RSpec.describe 'Delete single bill request', type: :request do
  context 'with valid auth token' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) { user.tokens.create(value: token) }

    context 'when bill is NOT found' do
      it 'returns 404 status code' do
        delete api_bill_path(1), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to have_http_status 404
      end

      it 'returns NOT found error message' do
        delete api_bill_path(1), params: {}, headers: { HTTP_AUTHORIZATION: token }

        expect(response.body).to include 'Bill with given ID not found'
      end
    end

    context 'when requested bill exists' do
      context 'user is the creator of the bill' do
        before(:each) { @bill = create(:bill, creator: user) }

        it 'returns 200 status code' do
          delete api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

          expect(response).to have_http_status 200
        end

        it 'contains the deletion success message' do
          delete api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

          expect(response.body).to include 'Bill deleted successfully'
        end
      end

      context 'user is the just a splitter of the bill' do
        before(:each) { @bill = create(:bill, splitters: [user.username]) }

        it 'returns 401 status code' do
          delete api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

          expect(response).to have_http_status 401
        end

        it 'contains unauthorized response message' do
          delete api_bill_path(@bill.id), params: {}, headers: { HTTP_AUTHORIZATION: token }

          expect(response.body).to include 'Unauthorized action on this bill'
        end
      end
    end
  end
end
