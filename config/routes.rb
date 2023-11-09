Rails.application.routes.draw do
  get 'positions/index'
  root to: 'positions#index'
  resources :casts, only: [:index]
  resources :positions, only: [:index]
end