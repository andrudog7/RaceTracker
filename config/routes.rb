Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#home'
  get "/types/:slug_races", to: 'types#show_races'
  get '/users/show_race_type'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  resources :users do 
    resources :friendships, only: [:create]
  end
  resources :friendships, only: [:update]
  resources :statistics, only: [:destroy] do 
      resources :likes, only: [:create]
    end
  resources :likes, only: [:update]
  resources :races do
    resources :statistics, only: [:new, :create, :index, :edit, :update] 
  end
  resources :types
  
  
end
