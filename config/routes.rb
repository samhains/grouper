Rails.application.routes.draw do

  root 'users#portal'

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', to: "users#new"
  get '/logout', to: "sessions#destroy"
  get '/inbox', to: "messages#index"
  get '/sent', to: "messages#sent"
  get '/my_threads', to: "discussions#my_discussions"
  get '/user/edit', to: "users#edit"
  patch '/user/edit', to: "users#update"

  resources :messages, except: [:destroy, :index]
  resources :users, only: [:create, :show] do
    collection do
      get 'search' 
    end
  end
  resources :discussions do
    put '/join', to: "discussions#join"
    delete '/leave', to: "discussions#leave"
    resources :posts, except: [:new, :index] do
        resources :comments, except: [:new, :index, :show]
    end
  end

end
