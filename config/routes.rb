Rails.application.routes.draw do
  devise_for :casts, controllers: { registrations: 'custom_registrations' }
  root to: 'positions#index'
  resources :casts do
    resources :workdays, only: [:show]
  end

  resources :positions, only: [:index] do
    collection do
      get :current
    end
  end

  resources :schedules, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :workdays


  get 'positions/tomorrow', to: 'positions#show_tomorrow', as: 'show_tomorrow_positions'
  get 'positions/day_after_tomorrow', to: 'positions#show_day_after_tomorrow', as: 'show_day_after_tomorrow_positions'
  get 'get_workdays_for_cast', to: 'workdays#for_cast'
end