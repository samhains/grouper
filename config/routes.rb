Rails.application.routes.draw do

  root 'users#portal'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', to: "users#new"
  get '/logout', to: "sessions#destroy"
 
  resources :users, only: [:create, :show]
  resources :groups do
    member do
      resources :posts, except: [:new]
    end
  end

end
