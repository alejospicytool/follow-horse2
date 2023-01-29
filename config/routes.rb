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
end
