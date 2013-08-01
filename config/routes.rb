# -*- encoding : utf-8 -*-
Helloworld::Application.routes.draw do
  resources :users
  
  root to: "pages#home"

  get '/signup',  to: 'users#new'
end
