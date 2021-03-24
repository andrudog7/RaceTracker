Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#home'
  get '/users/show_race_type'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#logout'
  get '/auth/google_oauth2/callback', to: 'sessions#omniauth'
  resources :users do 
    resources :friendships, only: [:create, :show]
  end
  resources :friendships, only: [:update]
  resources :statistics, only: [:destroy] do 
      resources :likes, only: [:create]
    end
  resources :likes, only: [:update]
  resources :races, except: [:destroy] do
    resources :statistics, only: [:new, :create, :index, :edit, :update] 
  end
  resources :types do 
    resources :statistics, only: [:index]
  end
  get "/types/:slug_races", to: 'types#show_races'
end
