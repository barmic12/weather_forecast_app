require 'rails_helper'

RSpec.describe 'Locations request', type: :request do
  let(:user) { create(:user) }
  describe 'GET #index' do
    context 'for logged user' do
      before do
        log_in_user(user)
        get '/locations'
      end
      it 'returns success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'for unlogged user' do
      before { get '/locations' }
      it 'returns redirect status' do
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
