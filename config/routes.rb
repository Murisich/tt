# -*- encoding : utf-8 -*-
Helloworld::Application.routes.draw do
  get "users/new"
  root to: "pages#home"

  get '/signup',  to: 'users#new'
end
