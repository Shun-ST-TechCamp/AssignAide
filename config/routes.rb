Rails.application.routes.draw do
  resources :casts, only: [:index]
end