Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :training_logs
      end

      get 'training_logs', to: 'training_logs#index'
      
      get 'login', to: 'sessions#new'
      post 'login', to: 'sessions#create'
      delete 'login', to: 'sessions#destroy'

      get 'current_user', to: 'current_users#show'
    end
  end
end