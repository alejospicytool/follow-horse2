Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => :registrations
  }
  root to: "pages#onboarding", as: 'onboarding'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")

  mount ActionCable.server => '/cable'

  # Home routes
  get 'home', to: 'pages#home', as: 'home'
  get 'slide1', to: 'pages#slide1', as: 'slide1'
  get 'slide2', to: 'pages#slide2', as: 'slide2'
  get 'slide3', to: 'pages#slide3', as: 'slide3'

  # Horses routes
  get 'horses/:id/edit', to: 'horses#edit', as: "horse_edit"
  get 'horses', to: 'horses#index'
  get 'potros', to: 'horses#potros', as: 'potros'
  get 'horses/filtros', to: 'horses#filtros', as: :horses_filtros
  post 'horses/aplicar_filtros', to: 'horses#aplicarfiltros', as: :horses_aplicar_filtros
  get 'horses/resultados', to: 'horses#resultados', as: :horses_results
  get 'horses/new', to: 'horses#new', as: 'horse_new'
  get 'horses/:id', to: 'horses#show', as: "horse_show"
  post 'horses', to: 'horses#create'
  put 'horses/:id', to: 'horses#update', as: "horse_update"
  delete 'horses/:id', to: 'horses#destroy', as: :horses_destroy

  # Auctions routes
  get 'active_auctions', to: 'auctions#active_auctions', as: 'active_auctions'
  get 'next_acutions', to: 'auctions#next_auctions', as: 'next_auctions'
  get 'auctions/new', to: 'auctions#new'
  post 'auctions', to: 'auctions#create'
  get 'auctions/:id', to: 'auctions#show', as: 'auction'
  get 'auctions/:id/edit', to: 'auctions#edit'
  put 'auctions/:id', to: 'auctions#update'
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
  resources :users do
    resources :reviews, only: :create
    end
  get 'favoritos/caballos', to: 'profiles#favorite_caballos', as: 'profile_favorite_caballos'
  get 'favoritos/remates', to: 'profiles#favorite_remates', as: 'profile_favorite_remates'
  get 'notificationes', to: 'profiles#notification', as: 'profile_notification'
  get 'mis_publicaciones/caballos', to: 'profiles#publication_caballos', as: 'profile_publication_caballos'
  get 'mis_publicaciones/remates', to: 'profiles#publication_remates', as: 'profile_publication_remates'
  post 'favorite_horse/:horse', to: 'favorites#update_horse', as: 'favorite_horse'
  post 'favorite_auction/:auction', to: 'favorites#update_auction', as: 'favorite_auction'
  get 'gracias_registo', to: 'pages#gracias', as: 'registro_gracias'

  # Reviews routes
  get 'approve_review/:id', to: 'reviews#approve', as: 'approve_review'
  get 'disapprove_review/:id', to: 'reviews#disapprove', as: 'disapprove_review'
  delete 'reviews/:id', to: 'reviews#destroy', as: 'review_destroy'

  # Conversation routes
  get 'conversaciones/activas', to: 'conversations#conversaciones_activas', as: 'conversaciones_activas'
  get 'conversaciones/archivadas', to: 'conversations#conversaciones_archivadas', as: 'conversaciones_archivadas'
  post 'conversaciones', to: 'conversations#create', as: 'conversaciones_create'
  get 'conversaciones/:id', to: 'conversations#show', as: 'conversacion_show'
  put 'conversaciones/:id/archivar', to: 'conversations#archivar', as: 'conversacion_archivar'
  put 'conversaciones/:id/desarchivar', to: 'conversations#desarchivar', as: 'conversacion_desarchivar'
  delete 'conversaciones/:id', to: 'conversations#destroy', as: 'conversacion_destroy'

  # Messages routes
  post 'mensajes', to: 'messages#create', as: 'conversation_messages'
  get 'favorite_horse/:id', to: 'favorites#delete_horse', as: 'favorite_delete_horse'
  get 'favorite_auction/:id', to: 'favorites#delete_auction', as: 'favorite_delete_auction'

  # Contact routes
  get '/contact', to: 'contact#index'
  post '/send_message', to: 'contact#send_message'

  # Admin routes
  get 'admin/contact/pending', to: 'admin#help_contact_pending', as: 'admin_help_contact_pending'
  get 'admin/contact/resolved', to: 'admin#help_contact_resolved', as: 'admin_help_contact_resolved'
  put 'admin/contact/:id', to: 'admin#help_update', as: 'admin_help_update'
  get 'admin/reviews/pending', to: 'admin#reviews_pending', as: 'admin_reviews_pending'
  get 'admin/reviews/resolved', to: 'admin#reviews_resolved', as: 'admin_reviews_resolved'
end
