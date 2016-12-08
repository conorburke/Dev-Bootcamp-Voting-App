Rails.application.routes.draw do
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :sessions, only: [:new, :create, :destroy]
  root :to => "home#index"
  get '/ideas' => "ideas#index"
  get '/ideas/new' => "ideas#new"
  post '/ideas' => "ideas#create"


end
