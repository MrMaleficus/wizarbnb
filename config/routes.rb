Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  resources :services, only: [:new, :create]
  resources :users, only: [:index, :show]

  get "profile" => "users#profile", as: :profile

  resources :services, only: :show do
    resources :reviews, only: [:new, :create, :index]
  end

  resources :services, except: [:edit, :update] do
    resources :bookings
  end

  post "bookings/:id/accept" => "bookings#accept", as: :accept_booking
  post "bookings/:id/decline" => "bookings#decline", as: :decline_booking

  #  resources :bookings, only: [:index, :show, :destroy]
  get "dashboard" => "dashboards#show"
  # Defines the root path route ("/")
  # root "posts#index"
end
