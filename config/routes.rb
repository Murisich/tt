# -*- encoding : utf-8 -*-
Helloworld::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  
  root to: "pages#home"

  get '/signup',  to: 'users#new'
  get '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
end
