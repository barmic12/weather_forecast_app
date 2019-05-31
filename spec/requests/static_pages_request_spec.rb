require 'rails_helper'

RSpec.describe 'StaticPages requests', type: :request do
  describe 'GET #home' do
    it 'returns success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end
end
