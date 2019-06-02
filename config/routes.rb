# frozen_string_literal: true

Rails.application.routes.draw do
  resources :registrations, only: %i[new create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  root to: 'static_pages#home'
end
