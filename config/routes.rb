Rails.application.routes.draw do
  devise_for :users
  root to: "pages#onboarding", as: 'onboarding'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  # Home routes
  get 'home', to: 'pages#home', as: 'home'
  get 'slide1', to: 'pages#slide1', as: 'slide1'
  get 'slide2', to: 'pages#slide2', as: 'slide2'
  get 'slide3', to: 'pages#slide3', as: 'slide3'

  # Horses routes
  resources :horses

  # Auctions routes
  get 'active_auctions', to: 'auctions#active_auctions', as: 'active_auctions'
  get 'next_acutions', to: 'auctions#next_auctions', as: 'next_auctions'
  get 'autions/new', to: 'auctions#new'
  post 'auctions', to: 'auctions#create'
  get 'autions/:id', to: 'auctions#show', as: 'auction'
  get 'autions/:id/edit', to: 'auctions#edit'
  put 'autions/:id', to: 'auctions#create'

  # Lotes views
  get 'auctions/:id/lotes', to: 'lotes#index'
  get 'auctions/:id/lotes/:id', to: 'lotes#show'
  get 'auctions/:id/lotes/new', to: 'lotes#new'
  post 'auctions/:id/lotes', to: 'lotes#create'
  get 'auctions/:id/lotes/:id/edit', to: 'lotes#edit'
  put 'auctions/:id/lotes/:id', to: 'lotes#update'

  # Menu views
  get 'search', to: 'pages#search', as: 'search'
  get 'add', to: 'pages#add', as: 'add'

  # Profile views
  get 'profile', to: 'profile#index', as: 'profile_index'
  get 'profile', to: 'profile#show', as: 'profile_show'
  get 'profile_favourite', to: 'profile#favourite', as: 'profile_favourite'
  get 'profile_notification', to: 'profile#notification', as: 'profile_notification'
  get 'profile_publication', to: 'profile#publication', as: 'profile_publication'

end
