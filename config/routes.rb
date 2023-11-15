Rails.application.routes.draw do
  devise_for :casts, controllers: { registrations: 'custom_registrations' }
  root to: 'positions#index'
  resources :casts, only: [:index, :new, :create, :edit, :update]
  resources :positions, only: [:index]
  resources :schedules, only: [:index, :new, :create]
end