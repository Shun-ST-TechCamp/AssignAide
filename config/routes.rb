Rails.application.routes.draw do
  devise_for :casts
  root to: 'positions#index'
  resources :casts, only: [:index,:new, :create]
  resources :positions, only: [:index]
end