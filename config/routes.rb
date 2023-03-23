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
  get 'horses', to: 'horses#index'
  get 'horses/new', to: 'horses#new', as: 'horse_new'
  get 'horses/:id', to: 'horses#show', as: "horse_show"
  post 'horses/create', to: 'horses#create'
  get 'horses/:id/edit', to: 'horses#edit'
  put 'horses/:id', to: 'horses#update'
  delete 'horses/:id', to: 'horses#destroy', as: :horses_destroy

  # Auctions routes
  get 'active_auctions', to: 'auctions#active_auctions', as: 'active_auctions'
  get 'next_acutions', to: 'auctions#next_auctions', as: 'next_auctions'
  get 'autions/new', to: 'auctions#new'
  post 'auctions', to: 'auctions#create'
  get 'autions/:id', to: 'auctions#show', as: 'auction'
  get 'autions/:id/edit', to: 'auctions#edit'
  put 'autions/:id', to: 'auctions#create'
  delete 'auctions/:id', to: 'auctions#destroy', as: :auction_destroy

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
  get 'perfiles', to: 'profiles#profile_index', as: 'profile_index'
  get 'perfiles/:id', to: 'profiles#show', as: 'profile_show'
  get 'favoritos/caballos', to: 'profiles#favourite_caballos', as: 'profile_favourite_caballos'
  get 'favoritos/remates', to: 'profiles#favourite_remates', as: 'profile_favourite_remates'
  get 'notificationes', to: 'profiles#notification', as: 'profile_notification'
  get 'mis_publicaciones/caballos', to: 'profiles#publication_caballos', as: 'profile_publication_caballos'
  get 'mis_publicaciones/remates', to: 'profiles#publication_remates', as: 'profile_publication_remates'
end
