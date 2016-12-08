Rails.application.routes.draw do
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"

  get '/session-viewer' => "sessions#view_session"

  get '/ideas/select/:id' => "ideas#add_sessions"

  get '/ideas' => "ideas#index"
  get '/ideas/new' => "ideas#new"
  post '/ideas' => "ideas#create"
  resources :sessions, only: [:new, :create, :destroy]
  # root 'ideas#index'

end
