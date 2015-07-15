Rails.application.routes.draw do

  root 'users#portal'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', to: "users#new"
  get '/logout', to: "sessions#destroy"
 
  resources :users, only: [:create, :show]
  resources :discussions do
    put '/join', to: "discussions#join"
    delete '/leave', to: "discussions#leave"
    resources :posts, except: [:new, :index] do
        resources :comments, except: [:new, :index, :show]
    end
  end

end
