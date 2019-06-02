require 'rails_helper'

RSpec.describe 'Account Settings request', type: :request do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'for logged user' do
      before do
        log_in_user(user)
        get '/account_settings'
      end
      it 'returns success' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'for unlogged user' do
      before { get '/account_settings' }
      it 'returns redirect status' do
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'for logged user' do
      before do
        log_in_user(user)
      end
      it 'removes user account' do
        expect { delete '/account_settings/destroy' }.to change { User.count }
      end
      it 'clear session' do
        delete '/account_settings/destroy'
        expect(session[:user_id]).to eq(nil)
      end
      it 'returns redirect status' do
        delete '/account_settings/destroy'
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'for unlogged user' do
      it 'does not remove user account' do
        expect { delete '/account_settings/destroy' }.to_not change { User.count }
      end
      it 'returns redirect status' do
        delete '/account_settings/destroy'
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
