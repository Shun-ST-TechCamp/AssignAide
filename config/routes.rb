Rails.application.routes.draw do
  devise_for :casts, controllers: { registrations: 'custom_registrations' }
  root to: 'positions#index'
  resources :casts, only: [:index, :new, :create, :edit, :update, :show] do
    resources :workdays, only: [:show]
  end

  resources :positions, only: [:index] do
    collection do
      get :current
    end
  end

  resources :schedules, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :workdays,  only: [:index, :new, :create, :edit, :update, :destroy, :show]

  get 'workdays/for_cast/:cast_id', to: 'workdays#for_cast'
end