Rails.application.routes.draw do
  devise_for :users
  root to: "pages#onboarding", as: 'onboarding'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'home', to: 'pages#home', as: 'home'
  get 'slide1', to: 'pages#slide1', as: 'slide1'
  get 'slide2', to: 'pages#slide2', as: 'slide2'
  get 'slide3', to: 'pages#slide3', as: 'slide3'

  resources :horses
  resources :auctions

  get 'search', to: 'pages#search', as: 'search'
  get 'add', to: 'pages#add', as: 'add'
  get 'profile', to: 'profile#index', as: 'profile_index'
  get 'profile', to: 'profile#show', as: 'profile_show'
  get 'profile_favourite', to: 'profile#favourite', as: 'profile_favourite'
  get 'profile_notification', to: 'profile#notification', as: 'profile_notification'
  get 'profile_publication', to: 'profile#publication', as: 'profile_publication'

end
