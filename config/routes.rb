Rails.application.routes.draw do
  
  get 'statistics/new'
  get 'statistics/create'
  get 'statistics/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#home'
  get '/users/show_race_type'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  resources :users
  resources :races do
    resources :statistics, only: [:new, :create, :index]
  end
  resources :types
end
