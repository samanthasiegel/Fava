Rails.application.routes.draw do
  get 'restaurants/index'

  get 'restaurants/import'

  resources :fava_users
  resources :account_activations, only: [:edit]
  resources :posts
  resources :payments
  root 'static_pages#home'
  get '/', to: 'static_pages#home'
  get '/signup', to: 'fava_users#new'
  get '/confirm', to: 'fava_users#confirm'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/getting_started', to: 'fava_users#getting_started'
  patch '/submit_pin', to: 'fava_users#submit_pin'
  get '/incorrect_pin', to: 'fava_users#incorrect_pin'
  post '/check_pin', to: 'requests#check_pin'

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
  get '/search_by_keyword', to: 'requests#search_by_keyword'
  get '/search', to: 'requests#search'
  get '/accept_request', to: 'requests#accept_request'
  get '/confirm_accept', to: 'requests#confirm_accept'


  get '/my_requests', to: 'requests#my_requests'
  get '/my_history', to: 'requests#my_history'
  get '/my_deliveries', to: 'requests#my_deliveries'

  get '/deposit', to: 'payments#index'
  get '/deposit/flex', to: 'payments#flex'
  get '/deposit/card', to: 'payments#card'

  get '/profile', to: 'requests#profile'
  get '/profile/change_password', to: 'requests#change_password'
  patch '/submit_new_password', to: 'requests#submit_new_password'

end
