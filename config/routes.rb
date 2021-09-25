Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :forecast
      resources :backgrounds
      resources :users
      resources :sessions
      resources :road_trip
    end
  end
end
