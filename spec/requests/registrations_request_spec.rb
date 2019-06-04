# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RegistrationsController', type: :request do
  describe 'GET #new' do
    it 'returns success' do
      get '/registrations/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_user) { build(:user) }
    let(:invalid_user) { build(:user, :invalid) }
    context 'with correct params' do
      it 'redirects to homepage' do
        post '/registrations', params: { user: FactoryBot.attributes_for(:user) }
        expect(response).to redirect_to('/')
      end
    end

    context 'with incorrect params' do
      it 'renders new' do
        post '/registrations', params: { user: FactoryBot.attributes_for(:user, :invalid) }
        expect(response).to have_http_status(200)
      end
    end
  end
end
