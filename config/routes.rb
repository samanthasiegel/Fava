Rails.application.routes.draw do
  resources :fava_users
  resources :account_activations, only: [:edit]
  root 'static_pages#home'
  get '/', to: 'static_pages#home'
  get '/signup', to: 'fava_users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

end
