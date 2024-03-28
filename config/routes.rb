Rails.application.routes.draw do
  devise_for :casts, controllers: { registrations: 'custom_registrations' }
  root to: 'positions#index'

  resources :casts, param: :company_id do
    resources :workdays, only: [:show,:edit]
  end

  resources :positions, only: [:index] do
    collection do
      get :current
    end
  end

  resources :schedules, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'new_position_schedule'
    end
    member do
      delete :remove_position_schedule
    end
  end

  resources :workdays do
    collection do
      post :create_for_cast_show
      delete :destroy_by_date
    end
  end

  get 'positions/tomorrow', to: 'positions#show_tomorrow', as: 'show_tomorrow_positions'
  get 'positions/day_after_tomorrow', to: 'positions#show_day_after_tomorrow', as: 'show_day_after_tomorrow_positions'
  get 'for_cast_on_date', to: 'workdays#for_cast_on_date'
  get 'schedules/for_cast_and_date', to: 'schedules#for_cast_and_date', as: 'cast_date_schedules'
  get 'positions/time_slot/:time_slot', to: 'positions#show_by_time_slot', as: 'show_by_time_slot'
  get 'schedules/new_for_tomorrow' , to: 'schedules#new_position_schedule_for_tomorrow', as: 'new_for_tomorrow_schedule'
  get 'schedules/new_for_day_after_tomorrow' , to: 'schedules#new_position_schedule_for_day_after_tomorrow', as: 'new_for_day_after_tomorrow_schedule'

  delete 'schedules/:id/remove_for_tomorrow', to: 'schedules#remove_position_schedule_for_tomorrow', as: 'remove_position_schedule_for_tomorrow'
  delete 'schedules/:id/remove_for_day_after_tomorrow', to: 'schedules#remove_position_schedule_for_day_after_tomorrow', as: 'remove_position_schedule_for_day_after_tomorrow'
end