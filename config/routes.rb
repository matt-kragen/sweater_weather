Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :backgrounds, only: [:index]
      resources :users, only: [:post]
      resources :sessions, only: [:post]
      resources :road_trip, only: [:post]
      resources :book_search, only: [:index], path: '/book-search'
    end
  end
end
