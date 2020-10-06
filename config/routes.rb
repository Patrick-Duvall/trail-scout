Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :trails, only: [:index]
      resources :trail_searches, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]

      namespace :user do
        resources :trail_searches, only: [:index]
      end
    end
  end
end
