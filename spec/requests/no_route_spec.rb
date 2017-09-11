require 'rails_helper'

RSpec.describe 'Requesting invalid path', type: :request do
  context 'when path does not exist' do
    let(:path) { '/this/path/does/not/exist' }

    it 'returns a 404 code' do
      get path

      expect(response).to have_http_status(404)
    end

    it 'contains the requested path in the response body' do
      get path

      expect(response.body).to include path
    end

    it 'contains error code "path not found"' do
      get path

      expect(response.body).to include 'Path not found'
    end
  end
end
