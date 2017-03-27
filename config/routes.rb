Rails.application.routes.draw do
  get 'restaurants/index'

  get 'restaurants/import'

  resources :fava_users
  resources :account_activations, only: [:edit]
  resources :posts
  root 'static_pages#home'
  get '/', to: 'static_pages#home'
  get '/signup', to: 'fava_users#new'
  get '/confirm', to: 'fava_users#confirm'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/timeline', to: 'posts#index'
  get '/post', to:'posts#new'
  get '/list', to:'posts#list_restaurants'
  get '/list_food', to:'posts#list_food'
  get '/food_item_profile', to:'posts#food_item_profile'
  get '/order', to:'posts#order'
  post '/post_order', to:'posts#post_order'
  get '/filter', to: 'posts#filter'
  get '/filter_by_cat', to: 'posts#filter_by_cat'

end
