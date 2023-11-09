Rails.application.routes.draw do
  devise_for :casts
  root to: 'positions#index'
  resources :casts, only: [:index]
  resources :positions, only: [:index]
end