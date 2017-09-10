require 'rails_helper'

RSpec.describe 'Create bill request', type: :request do
  context 'with valid auth token' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) { user.tokens.create(value: token) }

    context 'when the required parameters are available' do
      let(:bill_params) { attributes_for(:bill) }

      before(:each) do
        post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end

      it 'contains the attributes of the created bill in the body' do
        expect(response.body).to include bill_params[:title]
        expect(response.body).to include bill_params[:amount].to_s
      end
    end

    context 'when the bill amount is not provided' do
      let(:bill_params) { attributes_for(:bill, amount: nil) }

      before(:each) do
        post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }
      end

      it 'returns status code 400' do
        expect(response).to have_http_status 400
      end

      it 'contains the attributes of the created bill in the body' do
        expect(response.body).to include "Amount can't be blank"
      end
    end
  end
end
