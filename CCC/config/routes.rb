Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'users/new'

  #Gestione login e signup di loogle
  post "/google-users", to: "users#google_create"
  post "/google-login", to: "sessions#google_create"
  get "/google-login", to: "sessions#new"
  
  root "static_pages#home" 
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get"/login",to: "sessions#new"
  post"/login",to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
 
 
  resources :posts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  get '/posts', to: 'static_pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
