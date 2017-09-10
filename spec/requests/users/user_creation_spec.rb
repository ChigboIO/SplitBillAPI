require 'rails_helper'

RSpec.describe 'Creating a user', type: :request do
  context 'when the email address is not provided' do
    let(:user_params) { attributes_for(:user, email: nil) }
    before(:each) { post api_users_path, params: user_params }

    it 'returns 400 status code' do
      expect(response).to have_http_status(400)
    end

    it 'contains "email cannot be empty error message' do
      expect(response.body).to include "Email can't be blank"
    end
  end

  context 'when the username is not provided' do
    let(:user_params) { attributes_for(:user, username: nil) }
    before(:each) { post api_users_path, params: user_params }

    it 'returns 400 status code' do
      expect(response).to have_http_status(400)
    end

    it 'contains "username cannot be empty" error message' do
      expect(response.body).to include "Username can't be blank"
    end
  end

  context 'when the email is already in use' do
    let(:existing_user) { create(:user) }
    let(:user_params) { attributes_for(:user, email: existing_user.email) }
    before(:each) { post api_users_path, params: user_params }

    it 'returns 400 status code' do
      expect(response).to have_http_status(400)
    end

    it 'contains "email must be unique" error message' do
      expect(response.body).to include 'Email has already been taken'
    end
  end

  context 'when the email is not a valid email pattern' do
    let(:user_params) { attributes_for(:user, email: 'not-valid-email-pattern') }
    before(:each) { post api_users_path, params: user_params }

    it 'returns 400 status code' do
      expect(response).to have_http_status(400)
    end

    it 'contains "email is not valid" error message' do
      expect(response.body).to include 'Email is invalid'
    end
  end

  context 'when correct parameters are supplied' do
    let(:user_params) { attributes_for(:user) }
    before(:each) { post api_users_path, params: user_params }

    it 'returns 201 status code' do
      expect(response).to have_http_status(201)
    end

    it 'contains supplied email and username' do
      expect(response.body).to include user_params[:email]
      expect(response.body).to include user_params[:username]
    end
  end
end
