Rails.application.routes.draw do
  root to: 'positions#index'
  resources :casts, only: [:index]
  resources :positions, only: [:index]
end