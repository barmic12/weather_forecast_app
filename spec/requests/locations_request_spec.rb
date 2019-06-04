# frozen_string_literal: true

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

  describe 'GET #following' do
    context 'for logged user' do
      before do
        log_in_user(user)
        get '/locations/following'
      end
      it 'returns redirect status' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'for unlogged user' do
      before { get '/locations/following' }
      it 'returns redirect status' do
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'GET #follow' do
    let(:location) { create(:location) }
    context 'for logged user' do
      it 'creates new follow' do
        log_in_user(user)
        expect { get "/locations/follow/#{location.id}" }.to change { Follow.count }
      end

      it 'returns redirect status' do
         get "/locations/follow/#{location.id}"
         expect(response).to have_http_status(:redirect)
      end
    end

    context 'for unlogged user' do
      it 'does not create new follow' do
        expect { get "/locations/follow/#{location.id}" }.to_not change { Follow.count }
      end

      it 'returns redirect status' do
         get "/locations/follow/#{location.id}"
         expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #unfollow' do
    let(:location) { create(:location) }
    context 'for logged user' do
      it 'destroys follow' do
        log_in_user(user)
        create(:follow, user: user, location: location)
        expect { delete "/locations/unfollow/#{location.id}" }.to change { Follow.count }
      end

      it 'returns redirect status' do
         delete "/locations/unfollow/#{location.id}"
         expect(response).to have_http_status(:redirect)
      end
    end

    context 'for unlogged user' do
      it 'does not create new follow' do
        create(:follow, location: location)
        expect { delete "/locations/unfollow/#{location.id}" }.to_not change { Follow.count }
      end

      it 'returns redirect status' do
         delete "/locations/unfollow/#{location.id}"
         expect(response).to have_http_status(:redirect)
      end
    end
  end
end
