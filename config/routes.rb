# frozen_string_literal: true

Rails.application.routes.draw do
  resources :registrations, only: %i[new create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :account_settings, only: %i[index] do
    delete '/destroy', action: 'destroy', on: :collection
  end

  resources :locations, only: %i[index] do
    get '/following', action: 'following', on: :collection
    get '/follow/:id', action: 'follow', on: :collection, as: :follow
    delete '/unfollow/:id', action: 'unfollow', on: :collection, as: :unfollow
  end

  root to: 'static_pages#home'
end
