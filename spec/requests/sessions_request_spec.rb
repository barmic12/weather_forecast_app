# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions requests', type: :request do
  let(:user) { build(:user) }
  describe 'GET #new' do
    context 'for logged user' do

      it 'redirects to homepage' do
        log_in
        get '/login'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'for unlogged user' do
      it 'returns success' do
        get '/login'
        expect(response).to have_http_status(:success)
      end
    end

    context 'for removed user' do
      before do
        user = create(:user)
        log_in_user(user)
        user.destroy
      end
      it 'returns success' do
        get '/login'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'with valid params' do
      before { post '/login', params: { session: { email: user.email, password: user.password } } }

      it 'redirects to homepage' do
        expect(response).to redirect_to(root_path)
      end
      it 'set session' do
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid params' do
      before do
        invalid_password = "wrong#{user.password}"
        post '/login', params: { session: { email: user.email, password: invalid_password } }
      end

      it 'render new' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'DESTROY #destroy' do
    before do
      log_in
      delete '/logout'
    end
    it 'redirects to homepage' do
      expect(response).to redirect_to(root_path)
    end
    it 'clear cookies' do
      expect(session[:user_id]).to eq(nil)
    end
  end
end
