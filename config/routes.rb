Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#home'
  get '/users/show_race_type'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  resources :users
  resources :statistics, only: [:destroy, :update]
  resources :races do
    resources :statistics, only: [:new, :create, :index, :edit]
  end
  resources :types
  
end
