Rails.application.routes.draw do

  root 'users#portal'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', to: "users#new"
  get '/logout', to: "sessions#destroy"
 
  resources :users, only: [:create, :show]
  resources :groups do
    put '/join', to: "groups#join"
    delete '/leave', to: "groups#leave"
    resources :posts, except: [:new, :index] do
        resources :comments, except: [:new, :index, :show]
    end
  end

end
