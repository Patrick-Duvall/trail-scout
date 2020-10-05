Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :trails, only: [:index]
      resources :trail_searches, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
