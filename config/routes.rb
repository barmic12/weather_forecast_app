# frozen_string_literal: true

Rails.application.routes.draw do
  resources :registrations, only: %i[new create]

  root to: 'static_pages#home'
end
