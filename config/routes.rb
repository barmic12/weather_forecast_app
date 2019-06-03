# frozen_string_literal: true

Rails.application.routes.draw do
  resources :registrations, only: %i[new create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :account_settings, only: %i[index] do
    delete '/destroy', action: 'destroy', on: :collection
  end

  resources :locations, only: %i[index]

  root to: 'static_pages#home'
end
