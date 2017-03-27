Rails.application.routes.draw do
  get 'restaurants/index'

  get 'restaurants/import'

  resources :fava_users
  resources :account_activations, only: [:edit]
  resources :posts
  root 'static_pages#home'
  get '/', to: 'static_pages#home'
  get '/signup', to: 'fava_users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/timeline', to: 'posts#index'
  get '/post', to:'posts#new'

end
