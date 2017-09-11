require 'rails_helper'

RSpec.describe 'Create bill request', type: :request do
  context 'with valid auth token' do
    let(:user) { create(:user) }
    let(:token) { JwtProvider.encode(user_id: user.id) }
    before(:each) { user.tokens.create(value: token) }

    context 'when the required parameters are available' do
      let(:bill_params) { attributes_for(:bill) }

      it 'returns status code 201' do
        post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to have_http_status 201
      end

      it 'contains the attributes of the created bill in the body' do
        post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }

        expect(response.body).to include bill_params[:title]
        expect(response.body).to include bill_params[:amount].to_s
      end

      it 'changes the count of bill in the model by 1' do
        expect do
          post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }
        end.to change(Bill, :count).by 1
      end

      it 'creates new split for the number of splitters plus the creator' do
        expect do
          post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }
        end.to change(Split, :count).by(bill_params[:splitters].count + 1)
      end
    end

    context 'when the bill amount is not provided' do
      let(:bill_params) { attributes_for(:bill, amount: nil) }

      before(:each) do
      end

      it 'returns status code 400' do
        post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }

        expect(response).to have_http_status 400
      end

      it 'contains the attributes of the created bill in the body' do
        post api_bills_path, params: bill_params, headers: { HTTP_AUTHORIZATION: token }

        expect(response.body).to include "Amount can't be blank"
      end
    end
  end
end
