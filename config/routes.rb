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
  get '/getting_started', to: 'static_pages#getting_started'

  get '/timeline', to: 'requests#index'
  get '/completed', to: 'requests#completed'

  get '/complete_delivery', to: 'requests#complete_delivery'

  get '/list', to:'requests#list_restaurants'
  get '/list_food', to:'requests#list_food'
  get '/food_item_profile', to:'requests#food_item_profile'
  get '/order', to:'requests#order'
  get '/requests', to:'requests#new'
  post '/requests', to:'requests#create'
  get '/filter', to: 'requests#filter'
  get '/filter_by_cat', to: 'requests#filter_by_cat'
  get '/accept_request', to: 'requests#accept_request'
  get '/confirm_accept', to: 'requests#confirm_accept'


  get '/my_requests', to: 'requests#my_requests'
  get '/my_history', to: 'requests#my_history'
  get '/my_deliveries', to: 'requests#my_deliveries'

end
