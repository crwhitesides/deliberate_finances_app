Rails.application.routes.draw do

  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/auth/:provider/callback', to: 'sessions#twitter_login'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :plans, only: [:index, :show, :edit, :update] do
    resources :purchases, only: [:show, :new, :create, :edit, :update]
  end

  resources :purchases, only: [:destroy]
  resources :payments, only: [:show, :new, :destroy]

end
